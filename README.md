# Custom package repository

This is a collection of packages I packaged myself. Bundling these in such a way allows me to clean up the *inputs* section of my [configuration flake](https://github.com/nomisreual/nixdots).

## Included packages

The following packages are included with this flake. For more details feel free to head over to the respective repository.

- [mediaplayer](https://github.com/nomisreual/mediaplayer)
- [git_alert](https://github.com/nomisreual/git_alert)
- [sessionizer](https://github.com/nomisreual/sessionizer)

## Usage

As with other flakes, this flake can be added to your flake as input.
```nix
{
  description = "Your Configuration";

  inputs = {
    ...
    nomispkgs = {
      url = "github:nomisreual/nomispkgs";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    ...
  };
  outputs = {
    self,
    nixpkgs,
    nomispkgs,
    ...
  } @ inputs: {
    # your configurations
  };
}
```

You can then add any of the provided packages to your configuration. For example:

```nix
# configuration.nix
{
  environment.systemPackages = with pkgs; [
    ...

    nomispkgs.packages.<YOUR_ARCHITECTURE>.<PACKAGE_NAME>
    ...
  ];
}
# home.nix
{
  home.packages = with pkgs; [
    ...

    nomispkgs.packages.<YOUR_ARCHITECTURE>.<PACKAGE_NAME>
    ...
  ];
}
```
