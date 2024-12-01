{
  inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
  inputs.flake-utils.url = "github:numtide/flake-utils";
	inputs.godot-shell.url = "github:bkerz/godot-devshell";

  outputs = {
    self,
    nixpkgs,
    flake-utils,
		godot-shell,
  }:
    flake-utils.lib.eachDefaultSystem (system: let
      pkgs = nixpkgs.legacyPackages.${system};
      version = "stable";
			# hash = "sha256-rBVP1QFy7f7GHJFf/EsWh9M0uLbHwZXfyclGjjl8fls=";
			# hash = "sha256-LTrtlOxO18I/FpUST6z32atr4S9RWg1CvSTmquU4La0=";
			hash = "sha256-feVkRLEwsQr4TRnH4M9jz56ZN+5LqUNkw7fdEUJTyiE="; # stable
			# hash = "sha256-owG/N9lwdwrgE438gXH2BmcnLNKhdnh+krO2Mq8qztM="; # 4.4-dev3
			shell = godot-shell.lib.devShell {
				inherit pkgs;
				version = version;
				hash = hash;
			};
    in {
      devShell = shell;
    });
}
