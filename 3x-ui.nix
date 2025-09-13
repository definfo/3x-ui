{
  buildGo125Module,
  # fetchFromGitHub,
  xray,
  makeWrapper,
}:
buildGo125Module (finalAttrs: {
  pname = "3x-ui";
  version = "2.7.0";

  # src = fetchFromGitHub {
  #   owner = "MHSanaei";
  #   repo = finalAttrs.pname;
  #   tag = "v${finalAttrs.version}";
  #   hash = "sha256-51c3eTBAEx2+rd8i1GxE6oABVA3tTcrC/wOLXYOivds=";
  # };
  # patches = [
  #   ./0001-fix-go-version.patch
  # ];
  src = ./.;

  vendorHash = "sha256-Y2mOq1Kl4NK93Kck7iPoXBWaE6d6jJd1g+Sftur+Zqg=";

  nativeBuildInputs = [ makeWrapper ];

  buildInputs = [ xray ];

  postInstall = ''
    wrapProgram $out/bin/x-ui \
      --set XUI_DATA_FOLDER "/var/lib/x-ui" \
      --set XUI_DB_FOLDER "/var/lib/x-ui" \
      --set XUI_LOG_FOLDER "/var/log/x-ui" \
      --set XUI_BIN_FOLDER "$out/bin" \
      --set XRAY_BIN_PATH "${xray}/bin/xray" \
      --set XUI_LOG_LEVEL "info" \
  '';
})
