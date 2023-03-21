{
    description = "Nixos Wayland configuration";

    inputs = {
        nixpkgs.url = "github:nixos/nixpkgs/nixos-22.11";
        unstable.url = "github:nixos/nixpkgs/nixos-unstable";
        home-manager.url = "github:nix-community/home-manager/release-22.11";
        nixos-hardware.utl = "github:nixos/nixos-hardware";
        nixos-generators.url = "github:nix-community/nixos-generators";

        home-manager.inputs.nixpkgs.follows = "nixpkgs";
    };

    outputs = { self, nixpkgs, home-manager };

    let
        username = "user";
        pkgs = import nixpkgs {
            config.allowUnfree = true;
        };
        lib = nixpkgs.lib;

    in {
        nixosConfigurations = {
            vbox = lib.nixosSystem {
                modules = [
                    ./configuration.nix
                    home-manager.nixosModules.home-manager {
                        home-manager.useGlobalPkgs = true;
                        home-manager.userUserPackages = true;
                        home-manager.extraSpecialArgs = { inherit username };
                        home-manager.users.${username} = {
                            imports = [ ./home.nix ];
                        };
                    }
                ];
            };
        };
    };
}

