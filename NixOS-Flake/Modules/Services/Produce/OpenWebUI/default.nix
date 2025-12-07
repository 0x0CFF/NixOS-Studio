{ config, pkgs, inputs, ... }:

{
  services = {
    open-webui = {
      enable = true;
      host = "0.0.0.0";
      port = 8080;
      openFirewall = true;     # 开放防火墙端口
      environment = {
        # 身份验证
        # WEBUI_AUTH = "False";
        # Huggingface 镜像
        HF_ENDPOINT = "https://hf-mirror.com";
        # Ollama API URL
        # OLLAMA_API_BASE_URL = "http://127.0.0.1:11434";
      };
    };
  };
}
