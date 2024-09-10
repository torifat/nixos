{
  lib,
  fetchFromGitHub,
  stdenvNoCC,
  gtk3,
  ...
}:
stdenvNoCC.mkDerivation rec {
  pname = "vivid-glassy-dark-icon-theme";
  version = "unstable-07.09.2024";

  src = fetchFromGitHub {
    owner = "L4ki";
    repo = "Vivid-Plasma-Themes";
    rev = "cdcbad3bafca0c7a39fd8e4ccdbe493779e398ec";
    hash = "sha256-BPY9KhJ+l9YBkSnWB2ETwG7mSYRC3t/XJE6rLP8CqtE=";
  };

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
