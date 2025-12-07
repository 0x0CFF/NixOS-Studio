{ config, pkgs, inputs, ... }:

{
  services = {
    ollama = {
      enable = true;
      # package = "ollama-cpu";                  # 默认
      package = "ollama-rocm";                 # AMD GPU，如果 rocm 无法检测到 GPU，需要使用 services.ollama.rocmOverrideGfx 覆盖 GPU 类型
      # package = "ollama-cuda";                 # NVIDIA GPU
      # package = "ollama-vulkan";               # 大多数 GPU
      host = "0.0.0.0";
      port = 11434;
      openFirewall = true;                     # 开放防火墙端口
      acceleration = "rocm";                   # 使用 GPU 接口进行硬件加速（AMD: rocm, NVIDIA: cuda, 大多数 GPU: vulkan）
      rocmOverrideGfx = "10.3.0";              # AMD ROCm 平台强制指定 GPU 架构版本
      # loadModels = [                           # 预装模型
      #   "deepseek-r1:latest"
      # ];
      environmentVariables = {                 # 环境变量
        # HIP_VISIBLE_DEVICES = "0,1";           # 启用 AMD HIP
        # OLLAMA_ORIGINS = "*";
      };
    }
  }
}
