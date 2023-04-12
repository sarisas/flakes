{ stdenv
, lib
, fetchFromGitHub
, rustPlatform
, pkg-config
, libxkbcommon
,
}:
rustPlatform.buildRustPackage rec {
  pname = "bore";

  src = fetchFromGitHub {
    owner = "ekzhang";
    repo = "${pname}";
    rev = "931f2aa20b4b7b04defdd063167450ae4c981f44";
    hash = "hnAkOPbzaULz2X7vUL+b8U6Kn8NTquH9QR6B4/Tgi3Y=";
  };


  nativeBuildInputs = [ pkg-config ];

  buildInputs = [ libxkbcommon ];

  doCheck = false;

  meta = with lib; {
    description = "A modern, simple TCP to local ports to a remote server,";
    homepage = "https://github.com/ekzhang/${pname}";
    license = licenses.gpl3Only;
    platforms = [ "x86_64-linux" ];
  };
}
