{ config, pkgs, inputs, ... }:

{
  services = {
    n8n = {
      enable = true;
      openFirewall = true;
      webhookUrl = "";
      settings = {
        #
      };
    };
  };
}