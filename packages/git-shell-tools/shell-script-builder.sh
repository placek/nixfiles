#!/bin/sh
unset PATH

for p in $buildInputs; do
  export PATH=$p/bin${PATH:+:}$PATH
done

mkdir -p $out/bin
cp "$src" "$out/bin/$name"
