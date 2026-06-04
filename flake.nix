{
  description = "Custom package repository.";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    mediaplayer_ = {
      url = "github:nomisreual/mediaplayer";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    git_alert_ = {
      url = "github:nomisreual/git_alert";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    sessionizer_ = {
      url = "github:nomisreual/sessionizer";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    awww-info_ = {
      url = "github:nomisreual/awww_info";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = {
    self,
    nixpkgs,
    mediaplayer_,
    git_alert_,
    sessionizer_,
    awww-info_,
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
      mediaplayer = mediaplayer_.packages.${system}.default;
      git_alert = git_alert_.packages.${system}.pkg;
      sessionizer = sessionizer_.packages.${system}.default;
      awww-info = awww-info_.packages.${system}.default;
    });
  };
}
