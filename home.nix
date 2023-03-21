{ config, pkgs, username, ... }:

{
    home.username = username;
    home.homeDirectory = "/home/${username}";

    programs.home-manager.enable = true;
    programs.packages = with pkgs; [
        brave
    ]

    home.stateVersion = "22.05";
}
