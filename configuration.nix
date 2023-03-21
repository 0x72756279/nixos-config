{ config, pkgs, ... }:

{
    imports = [
        ./hardware-configuration.nix
    ];

    boot.loader.grub.enable = true;
    boot.loader.grub.useOSProber = true;

    time.timeZone = "Asia/Jerusalem";

    i18n.defaultLocale = "en_IL.utf8";

    nix = {
        settings = {
            auto-optimise-store = true;
        };
        gc = {
            automatic = true;
            dates = "weekly";
            options = "--delete-older-than 7d";
        };
        extraOptions = ''
            experimental-features = nixcommand flakes
            keep-outputs = true
            keep-derivations = true
        '';
    };

    nixpkgs.config.allowUnfree = true;

    environment.systemPackages = with pkgs; [
        neovim
    ];

    system.stateVersion = "22.05";
}
