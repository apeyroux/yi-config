{ pkgs ? import <nixpkgs> {} }:

with pkgs;

stdenv.mkDerivation {
  name = "yi-config";
  buildInputs = [ haskellPackages.stack haskellPackages.cabal-install icu haskell.compiler.ghc802 ncurses ];
  shellHook = ''
    export LD_LIBRARY_PATH="${ncurses}/lib:${icu}/lib:$LD_LIBRARY_PATH"
  ''; 
}
