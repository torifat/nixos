# Custom package overlay
#
# Scans ./packages/ for directories, each containing a default.nix that defines
# a package. Packages listed in broken.nix are excluded from the build.
# Each package's default.nix can optionally accept:
#   - mySource: auto-injected from _sources/generated.nix (via nvfetcher)
#   - basePackage: the existing nixpkgs package of the same name (for overrides)
let
  pkgDir = ./packages;
  generated = import ./_sources/generated.nix;
  broken = import ./broken.nix;

  genPkg = f: name: {
    inherit name;
    value = f name;
  };
in
final: prev:
let
  names = with builtins; prev.lib.subtractLists broken (attrNames (readDir pkgDir));
  withContents = f: with builtins; listToAttrs (map (genPkg f) names);
in
prev.lib.composeManyExtensions [
  # Inject nvfetcher sources into pkgs.sources
  (final: prev: {
    sources = generated {
      inherit (final)
        fetchurl
        fetchgit
        fetchFromGitHub
        dockerTools
        ;
    };
  })
  # Build each package from ./packages/<name>/default.nix
  (
    final: prev:
    withContents (
      name:
      let
        pkg = import (pkgDir + "/${name}");
        override = builtins.intersectAttrs (builtins.functionArgs pkg) {
          mySource = prev.sources.${name} or null;
          basePackage = prev.${name} or null;
        };
      in
      final.callPackage pkg override
    )
  )
] final prev
