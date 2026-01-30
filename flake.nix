{
  description = "mber's NixOS configuration";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    # FortiVPN Client
    fortivpn-client = {
      url = "git+ssh://git@github.com/mrbergeron83/forticlientvpn.git";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, fortivpn-client, ... }@inputs: {
    nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      specialArgs = { inherit inputs; };
      modules = [
        ./configuration.nix
        fortivpn-client.nixosModules.default
        {
          # Enable the FortiVPN client
          programs.fortivpn-client.enable = true;
        }
      ];
    };
  };
}
