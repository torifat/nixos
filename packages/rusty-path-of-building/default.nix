{
  pkgs,
  mySource,
  basePackage,
  ...
}:
# use latest version
basePackage.overrideAttrs (
  mySource
  // {
    cargoDeps = pkgs.rustPlatform.importCargoLock {
      lockFile = mySource.src + "/Cargo.lock";
      allowBuiltinFetchGit = true;
    };
  }
)
