{
  description = "Rifat's NixOS";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    nixpkgs-stable.url = "github:nixos/nixpkgs/nixos-24.05";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    disko = {
      url = "github:nix-community/disko";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    hyprland.url = "github:hyprwm/Hyprland";
    stylix.url = "github:danth/stylix";
    sddm-sugar-candy-nix.url = "gitlab:Zhaith-Izaliel/sddm-sugar-candy-nix";
    zen-browser.url = "github:0xc000022070/zen-browser-flake";
    solarr = {
      url = "https://flakehub.com/f/Svenum/Solaar-Flake/*.tar.gz";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    {
      self,
      nixpkgs,
      home-manager,
      disko,
      stylix,
      sddm-sugar-candy-nix,
      zen-browser,
      solarr,
      ...
    }@inputs:
    let
      genPkg = f: name: {
        inherit name;
        value = f name;
      };
      settings = import (./settings.nix) { };
      pkgDir = ./packages;
      generated = import ./_sources/generated.nix;
      broken = import ./broken.nix;
      system = settings.system;
      names = with builtins; nixpkgs.lib.subtractLists broken (attrNames (readDir pkgDir));
      withContents = f: with builtins; listToAttrs (map (genPkg f) names);
    in
    {
      overlays.default =
        final: prev:
        prev.lib.composeManyExtensions [
          (final: prev: {
            sources = generated {
              inherit (final)
                fetchurl
                fetchgit
                fetchFromGitHub
                dockerTools
                ;
            };
          })
          (
            final: prev:
            withContents (
              name:
              let
                pkg = import (pkgDir + "/${name}");

                override = builtins.intersectAttrs (builtins.functionArgs pkg) ({
                  mySource = prev.sources.${name} or null;
                });
              in
              final.callPackage pkg override
            )
          )
        ] final prev;
    }
    // (
      let
        pkgs = import nixpkgs {
          system = settings.system;
          overlays = [ self.overlays.default ];
          config.allowUnfree = true;
          config.permittedInsecurePackages = [
            "ventoy-1.1.07"
          ];
        };
      in
      {
        formatter.${system} = pkgs.nixfmt-rfc-style;
        nixosConfigurations.lovelace = nixpkgs.lib.nixosSystem {
          inherit system;
          pkgs = pkgs;
          modules = [
            solarr.nixosModules.default
            ./configuration.nix
            home-manager.nixosModules.home-manager
            {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.users.${settings.username} = import ./home;
              home-manager.backupFileExtension = "backup";
              home-manager.extraSpecialArgs = {
                inherit settings;
              };
            }
            {
              nix = {
                settings.experimental-features = [
                  "nix-command"
                  "flakes"
                ];
              };
            }
            disko.nixosModules.disko
            {
              environment.systemPackages = [
                zen-browser.packages.${system}.default
              ];
            }
            stylix.nixosModules.stylix
            sddm-sugar-candy-nix.nixosModules.default
          ];
          specialArgs = {
            inherit settings inputs;
          };
        };
      }
    );
}
# vim:et:sw=2:ts=2:sta:nu
