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
      "base01-hex":         "3c3836",
      "base02-hex":         "504945",
      "base03-hex":         "665c54",
      "base04-hex":         "bdae93",
      "base05-hex":         "d5c4a1",
      "base06-hex":         "ebdbb2",
      "base07-hex":         "fbf1c7",
      "base08-hex":         "fb4934",
      "base09-hex":         "fe8019",
      "base0A-hex":         "fabd2f",
      "base0B-hex":         "b8bb26",
      "base0C-hex":         "8ec07c",
      "base0D-hex":         "83a598",
      "base0E-hex":         "d3869b",
      "base0F-hex":         "d65d0e"
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
