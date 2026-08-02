#!/bin/sh
RGBDS="/home/tw/git/pokemon/rgbds-linux-x86_64/"
export PATH="$RGBDS:$PATH"

# Regenerate all 2bpp sprite graphics from PNGs
echo "=== Regenerating sprite graphics ==="
for png in gfx/sprites/*.png; do
    bpp="${png%.png}.2bpp"
    if [ "$png" -nt "$bpp" ] || [ ! -f "$bpp" ]; then
        echo "  $png -> $bpp"
        rgbgfx --colors dmg -o "$bpp" "$png"
    fi
done

# Build ROMs
echo ""
echo "=== Building pokered.gbc ==="
make RGBDS="$RGBDS" pokered.gbc || exit 1

echo ""
echo "=== Building pokeblue.gbc ==="
make RGBDS="$RGBDS" pokeblue.gbc || exit 1

echo ""
echo "Done."
