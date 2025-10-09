{ config, pkgs, inputs, ... }:

{
  services = {
    ollama = {
      enable = true;
      host = "0.0.0.0";
      port = 11434;
      home = "%S/ollama";                      # 启动 Ollama 服务的主目录
      models = "%S/ollama/models";             # 读取模型并将新模型下载到其中的目录
      acceleration = "rocm";                   # 使用 GPU 接口进行硬件加速（AMD: rocm, NVIDIA: cuda）
      # sandbox = true;                          # systemd 沙盒功能，将设置 DynamicUser ，以唯一用户身份运行服务器，对大部分文件系统具有只读访问权限
      # writablePaths = [                        # 允许通过默认沙箱写入指定的路径
      #   "/home/0x0CFF/Downloads"
      # ];
      environmentVariables = {                 # 环境变量
        HIP_VISIBLE_DEVICES = "0,1";           # 启用 AMD HIP
        # OLLAMA_LLM_LIBRARY = "cpu";          # 指定 LLM 硬件模式为 CPU
        HSA_OVERRIDE_GFX_VERSION = "10.3.0";   # AMD ROCm 平台强制指定 GPU 架构版本
        OLLAMA_HOST = "0.0.0.0";
        OLLAMA_ORIGINS = "*";
      };
    }
  }
}