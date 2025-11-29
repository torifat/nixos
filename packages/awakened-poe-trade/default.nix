{
  appimageTools,
  mySource,
  ...
}:
let
  appimageContents = appimageTools.extract {
    inherit (mySource) pname version src;
  };
in
appimageTools.wrapType2 (
  mySource
  // {
    extraInstallCommands = ''
      install -m 444 -D ${appimageContents}/awakened-poe-trade.desktop $out/share/applications/${mySource.pname}.desktop
      substituteInPlace $out/share/applications/awakened-poe-trade.desktop \
        --replace "Exec=AppRun --sandbox %U" "Exec=awakened-poe-trade --ozone-platform=x11 %U"

      install -m 444 -D ${appimageContents}/awakened-poe-trade.png $out/share/icons/hicolor/128x128/apps/${mySource.pname}.png
    '';

    meta = {
      platforms = [ "x86_64-linux" ];
    };
  }
)
