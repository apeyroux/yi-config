{ pkgs ? import <nixpkgs> {} }:

with pkgs;

stdenv.mkDerivation {
  name = "yi-config";
  buildInputs = [ haskellPackages.stack haskellPackages.cabal-install icu.out haskell.compiler.ghc802 ncurses.out ];
}
