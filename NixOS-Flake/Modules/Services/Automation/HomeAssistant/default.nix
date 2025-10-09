{ config, pkgs, inputs, ... }:

{
  services = {
    home-assistant = {
      enable = true;
      openFirewall = true;
    };
  };
}