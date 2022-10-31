{ pkgs, lib, ... }:

let
  dfVersion     = "0.47.05";
  sha256        = "rHSm27fX2WIfQwQFCAMiq1DDX2YyNS/y6pI/bcWv/KM=";
  url           = "http://www.bay12games.com/dwarves/df_47_05_linux.tar.bz2";
  unfuckRelease = "0.47.04";
  unfuckSha256  = "1wa990xbsyiiz7abq153xmafvvk1dmgz33rp907d005kzl1z86i9";

  dfu = pkgs.stdenv.mkDerivation {
    name = "df-unfuck-placek";

    src = pkgs.fetchFromGitHub {
      owner  = "svenstaro";
      repo   = "dwarf_fortress_unfuck";
      rev    = unfuckRelease;
      sha256 = unfuckSha256;
    };

    nativeBuildInputs = with pkgs; [ cmake pkg-config ];
    buildInputs = with pkgs; [
      xorg.libSM
      SDL
      SDL_image
      SDL_ttf
      glew
      openalSoft
      ncurses
      libsndfile
      zlib
      libGL
      gtk3
    ];

    installPhase = ''
      install -D -m755 ../build/libgraphics.so $out/lib/libgraphics.so
    '';

    passthru = { inherit dfVersion; };
  };

  libpath = lib.makeLibraryPath [ pkgs.stdenv.cc.cc pkgs.stdenv.cc.libc pkgs.SDL dfu ];

  df = pkgs.stdenv.mkDerivation rec {
    pname = "dwarf-fortress-placek";
    version = dfVersion;

    src = builtins.fetchurl { inherit url sha256; };

    colors = ./colors.txt;
    theme = ./theme.png;
    textMode = true;
    installPhase = ''
      mkdir -p $out
      cp -r * $out
      rm $out/libs/lib*
      exe=$out/libs/Dwarf_Fortress
      # Store the original hash
      md5sum $exe | awk '{ print $1 }' > $out/hash.md5.orig
      patchelf \
        --set-interpreter $(cat ${pkgs.stdenv.cc}/nix-support/dynamic-linker) \
        --set-rpath "${libpath}" \
        $exe
      # default settings
      cp $colors $out/data/init/colors.txt
      cp $theme $out/data/art/theme.png
      substituteInPlace $out/data/init/init.txt \
    '' + (if textMode then
    ''
        --replace '[PRINT_MODE:2D]' '[PRINT_MODE:TEXT]' \
    ''
    else
    ''
        --replace '[TRUETYPE:YES]' '[TRUETYPE:NO]' \
        --replace '[BLACK_SPACE:YES]' '[BLACK_SPACE:NO]' \
        --replace '[FONT:curses_640x300.png]' '[FONT:theme.png]' \
    '') +
    ''
        --replace '[INTRO:YES]' '[INTRO:NO]' \
        --replace '[SOUND:YES]' '[SOUND:NO]'
      # Store the new hash
      md5sum $exe | awk '{ print $1 }' > $out/hash.md5
    '';
  };

  env = pkgs.buildEnv {
    name = "dwarf-fortress-env-placek";
    paths = [ df ];
    pathsToLink = [ "/" "/hack" "/hack/scripts" ];
    ignoreCollisions = true;
  };
in
  pkgs.stdenv.mkDerivation {
    name = "dwarf-placek";

    dfInit = pkgs.substituteAll {
      name = "dwarf-fortress-init-placek";
      src = ./dwarf-init.in;
      inherit env;
      exe = "libs/Dwarf_Fortress";
      stdenv_shell = "${pkgs.stdenv.shell}";
      cp = "${pkgs.coreutils}/bin/cp";
      rm = "${pkgs.coreutils}/bin/rm";
      ln = "${pkgs.coreutils}/bin/ln";
      cat = "${pkgs.coreutils}/bin/cat";
      mkdir = "${pkgs.coreutils}/bin/mkdir";
    };

    runDF = ./dwarf.in;

    buildCommand = ''
      mkdir -p $out/bin
      substitute $runDF $out/bin/dwarf \
        --subst-var-by stdenv_shell ${pkgs.stdenv.shell} \
        --subst-var dfInit
      chmod 755 $out/bin/dwarf
    '';

    preferLocalBuild = true;
  }
