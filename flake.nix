{
  description = "Custom package repository.";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    mediaplayer = {
      url = "github:nomisreual/mediaplayer";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    git_alert = {
      url = "github:nomisreual/git_alert";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    sessionizer = {
      url = "github:nomisreual/sessionizer";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = {
    self,
    nixpkgs,
    mediaplayer,
    git_alert,
    sessionizer,
  }: let
    allSystems = [
      "x86_64-linux"
      "aarch64-linux"
      "x86_64-darwin"
      "aarch64-darwin"
    ];

    forAllSystems = f:
      nixpkgs.lib.genAttrs allSystems (system: let
        pkgs = import nixpkgs {inherit system;};
      in
        f {inherit pkgs system;});
  in {
    packages = forAllSystems ({
      pkgs,
      system,
    }: rec {
      mediaplayer = mediaplayer.packages.${system}.default;
      git_alert = git_alert.packages.${system}.default;
      sessionizer = sessionizer.packages.${system}.default;
    });
    mediaplayer = packages.mediaplayer;
  };
}
