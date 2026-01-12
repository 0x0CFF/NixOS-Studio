{ config, pkgs, inputs, ... }:

{
  # 在 timers 服务中启用 systemd 单元
  systemd.timers."health-disk" = {
    wantedBy = [ "timers.target" ];
    timerConfig = {
      # 在系统运行时，每年 1 月 1 日开始，每 2 个月循环，在 05：00：00 运行任务
      OnCalendar = "*-*-* 06:00:00";
      # 如果服务在执行时间内由于意外没有触发，则立即补执行
      Persistent = true;
      # 随机延迟执行，避免多个任务同时启动
      RandomizedDelaySec = "5min";
    };
  };

  # 定义 systemd 单元
  systemd.services."health-disk" = {
    # 运行脚本
    # 查找程序所在位置 echo $(which ssh)
    script = ''
      DISKS=(
        "/dev/disk/by-id/硬盘-id"
        # 添加更多硬盘...
      )
      
      # 检查设备是否存在
      if [ ! -e "$DEVICE" ]; then
        echo "错误：设备 $DEVICE 不存在。"
        exit 1
      fi
      
      # 函数：检查设备是否支持 SMART
      check_smart_support() {
        if ! smartctl -i "$DEVICE" | grep -i "SMART support is:" | grep -q "Enabled"; then
          echo "错误：设备 $DEVICE 不支持 SMART 或 SMART 未启用。"
          exit 1
        fi
      }      
    
      # 函数：判断今天是否为月份最后一个周日
      is_last_sunday_of_month() {
        # 获取今天的日期信息
        local today=$(date +%Y-%m-%d)
        local current_year=$(date +%Y)
        local current_month=$(date +%m)
          
        # 获取今天是星期几（0=周日，1=周一，...，6=周六）
        local day_of_week=$(date +%w)
          
        # 如果不是周日，直接返回 false
        if [ "$day_of_week" -ne 0 ]; then
          return 1  # false
        fi
          
        # 获取这个月的天数
        local days_in_month=$(cal $(date +"%m %Y") | awk 'NF {DAYS = $NF}; END {print DAYS}')
          
        # 获取今天是几号
        local current_day=$(date +%d)
          
        # 如果是周日，并且日期在 (天数-6) 到 天数 之间，则可能是最后一个周日
        # 循环检查今天之后是否还有周日
        for (( i=1; i<=7; i++ )); do
          local future_date=$(date -d "$today + $i days" +%Y-%m-%d)
          local future_day_of_week=$(date -d "$future_date" +%w)
          local future_month=$(date -d "$future_date" +%m)
              
          # 如果未来的某天还是周日，且仍在同一个月，说明今天不是最后一个周日
          if [ "$future_day_of_week" -eq 0 ] && [ "$future_month" = "$current_month" ]; then
            return 1  # false
          fi
        done
          
        return 0  # true
      }
      
      # 函数：执行短检查
      run_short_test() {
        echo "$(date): 开始执行短检查（短自检）..."
        echo "设备: $DEVICE"
          
        # 执行短自检（通常需要约2分钟）
        smartctl -t short "$DEVICE"
          
        if [ $? -eq 0 ]; then
          echo "短检查已启动，通常需要约2分钟完成。"
          echo "使用以下命令查看测试结果："
          echo "smartctl -l selftest $DEVICE"
        else
          echo "错误：启动短检查失败。"
          exit 1
        fi
      }
      
      # 函数：执行长检查
      run_long_test() {
        echo "$(date): 开始执行长检查（扩展自检）..."
        echo "设备: $DEVICE"
          
        # 执行长自检（通常需要数小时，取决于硬盘大小）
        smartctl -t long "$DEVICE"
          
        if [ $? -eq 0 ]; then
          echo "长检查已启动，通常需要数小时完成（取决于硬盘容量）。"
          echo "使用以下命令查看测试结果："
          echo "smartctl -l selftest $DEVICE"
        else
          echo "错误：启动长检查失败。"
          exit 1
        fi
      }
      
      # 函数：检查是否有测试正在进行
      check_running_test() {
        local test_status=$(smartctl -a "$DEVICE" | grep -i "self-test execution status" | head -1)
        if echo "$test_status" | grep -q "in progress"; then
          echo "警告：已有测试正在进行中。跳过本次检查。"
          exit 0
        fi
      }
      
      # 主函数
      main() {

        echo "设备: $DEVICE"
        echo "当前时间: $(date)"
        echo ""
          
        # 检查 SMART 支持
        check_smart_support
          
        # 检查是否有测试正在进行
        check_running_test
          
        # 判断是否为月份最后一个周日
        if is_last_sunday_of_month; then
          # 今天是月份最后一个周日，执行长检查
          run_long_test
        else
          # 今天不是月份最后一个周日，执行短检查
          run_short_test
        fi
      }
      
      # 执行主函数
      main
    '';
    # 单元配置
    serviceConfig = {
      Type = "oneshot";
      User = "root";
    };
  };
}
