{ pkgs ? import <nixpkgs> {} }:
  pkgs.mkShell {
    buildInputs = [
      pkgs.elixir
      pkgs.httpie
      pkgs.mc
    ];
}
