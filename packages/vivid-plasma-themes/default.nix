{
  lib,
  stdenv,
  gtk3,
  mySource,
  ...
}:
stdenv.mkDerivation rec {
  inherit (mySource) pname version src;

  nativeBuildInputs = [ gtk3 ];
  dontDropIconThemeCache = true;

  installPhase = ''
    runHook preInstall

    mkdir -p $out/share/icons
    mv Vivid\ Icons\ Themes/Vivid-Glassy-Dark-Icons $out/share/icons/${pname}
    gtk-update-icon-cache $theme

    runHook postInstall
  '';

  meta = with lib; {
    homepage = "https://github.com/L4ki/Vivid-Plasma-Themes";
    description = "Vivid Plasma Themes";
    license = licenses.gpl3Plus;
    platforms = platforms.linux;
  };
}
