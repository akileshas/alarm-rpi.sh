{
  description = "Install ArchLinux ARM in Raspberry pi 5";
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-parts.url = "github:hercules-ci/flake-parts";
  };

  outputs = inputs@{flake-parts, ...}:
    flake-parts.lib.mkFlake {inherit inputs;} {
      systems = [
        "x86_64-linux"
        "aarch64-linux"
        "aarch64-darwin"
        "x86_64-darwin"
      ];
      perSystem = {pkgs,...}: {
        packages.default = pkgs.writeShellApplication {
          name="alarm-install";
          runtimeInputs = [pkgs.fzf];
          text = builtins.readFile ./build.sh;
        };
        devShells.default = pkgs.mkShell {
          name="alarm-install-devshell";
          meta.description = "Shell environment for alarm_install script";
          packages = with pkgs;[fzf];
        };
      };
    };
}
