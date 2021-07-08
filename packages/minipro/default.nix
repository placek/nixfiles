{ stdenv, installShellFiles, fetchFromGitLab, pkg-config, libusb1 }:
stdenv.mkDerivation rec {
  pname   = "minipro";
  version = "0.5";

  src = fetchFromGitLab {
    owner  = "DavidGriffith";
    repo   = "minipro";
    rev    = "8be592c954264afdc3a2cb596ee45517cc5dc621";
    sha256 = "15x0rmwvnznkh43chb5la1xg5c0xqw1gj1r8iqlwlnrv4qpzca0z";
  };

  nativeBuildInputs = [ pkg-config installShellFiles ];
  buildInputs       = [ libusb1 ];

  preConfigure = ''
    export PKG_CONFIG="${pkg-config}/bin/pkg-config";
    substituteInPlace Makefile --replace '$(shell date "+%Y-%m-%d %H:%M:%S %z")' "1970-01-01 00:00:00 +0000"
  '';

  makeFlags = [ "-e minipro" ];

  installPhase = ''
    mkdir $out/bin $out/lib/udev/rules.d -pv
    cp -rv ./minipro $out/bin/
    mv udev/* $out/lib/udev/rules.d/ -v
    installManPage ./man/minipro.1
    installShellCompletion --bash ./bash_completion.d/minipro
  '';

  meta = {
    description = "An open source program for controlling the MiniPRO TL866xx series of chip programmers";
    homepage = "https://gitlab.com/DavidGriffith/minipro";
  };
}
