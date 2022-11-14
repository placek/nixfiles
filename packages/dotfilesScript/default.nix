{ pkgs, mobile ? false }:

let
  dotfiles_configuration = builtins.toFile "dotfiles.json" ''
    {
      "font":               "Iosevka",
      "font-size":          "12",
      "border-half-size":   "2",
      "border-size":        "4",
      "border-double-size": "8",
      "terminal":           "kitty",
      "browser":            "qutebrowser",
      "mobile":             ${builtins.toJSON mobile},
      "base00-hex":         "32302f",
      "base08-hex":         "504945",
      "base01-hex":         "cc241d",
      "base09-hex":         "fb4934",
      "base02-hex":         "98971a",
      "base0A-hex":         "b8bb26",
      "base03-hex":         "d79921",
      "base0B-hex":         "fabd2f",
      "base04-hex":         "458588",
      "base0C-hex":         "83a598",
      "base05-hex":         "b16286",
      "base0D-hex":         "d3869b",
      "base06-hex":         "689d6a",
      "base0E-hex":         "8ec07c",
      "base07-hex":         "a89984",
      "base0F-hex":         "ebdbb2"
    }
  '';
in
  ''
    export LANG=C.utf8
    data_file="${dotfiles_configuration}"
    source_dir="${pkgs.custom.dotfiles}/share"
    target_dir=$HOME
    dotfiles_dir=$target_dir/.config/dotfiles
    rm -rf $dotfiles_dir
    mkdir -p $dotfiles_dir
    cp -rv $source_dir/* $dotfiles_dir
    chmod -R +w $dotfiles_dir
    for file in $(find $dotfiles_dir -name "*.mustache" -type f); do
      target=$(echo $file | ${pkgs.gnused}/bin/sed 's/\.mustache$//')
      ${pkgs.haskellPackages.mustache}/bin/haskell-mustache $file $data_file > $target
      rm -f $file
    done
    chmod -R +w $dotfiles_dir
    for dir in $(find $source_dir/* -mindepth 1 -type d -printf "%P\n"); do
      mkdir -p  $target_dir/$dir
      chmod 700 $target_dir/$dir
    done
    true
  ''
