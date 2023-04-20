{
  inputs = {
    darwin = {
      url = "github:LnL7/nix-darwin";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    home-manager = {
      url = "github:stackbuilders/home-manager/add_delta_package_option";
      # url = "path:/Users/sestrella/code/stackbuilders/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
  };

  outputs = { self, darwin, home-manager, nixpkgs }: {
    darwinConfigurations =
      let
        mkDarwinSystem = system: darwin.lib.darwinSystem {
          inherit system;
          modules = [
            ./configuration.nix
            home-manager.darwinModules.home-manager
            {
              home-manager = {
                backupFileExtension = "bak";
                users.sestrella = import ./home.nix;
              };
            }
          ];
        };
      in
      {
        "Administrators-MacBook-Pro" = mkDarwinSystem "aarch64-darwin";
        "ghactions" = mkDarwinSystem "x86_64-darwin";
      };
  };
}
