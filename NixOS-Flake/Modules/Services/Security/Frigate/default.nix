{ config, pkgs, inputs, ... }:

{
  services = {
    frigate = {
      enable = true;
      settings = {
        #
      };
    };
  };
}
