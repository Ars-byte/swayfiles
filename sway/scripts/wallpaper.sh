#!/bin/bash
DIR="/home/clippy/Imágenes/wallpapers"
STATE_FILE="$HOME/.cache/wallpaper_index"

WALLPAPERS=()
while IFS= read -r -d $'\0' f; do
    WALLPAPERS+=("$f")
done < <(find "$DIR" -type f \( -iname "*.jpg" -o -iname "*.jpeg" -o -iname "*.png" -o -iname "*.gif" -o -iname "*.webp" \) -print0 | sort -z)

TOTAL=${#WALLPAPERS[@]}

if [[ $TOTAL -eq 0 ]]; then
    echo "No se encontraron imágenes en $DIR"
    exit 1
fi

if [[ -f "$STATE_FILE" ]]; then
    INDEX=$(cat "$STATE_FILE")
else
    INDEX=0
fi

if ! [[ "$INDEX" =~ ^[0-9]+$ ]]; then
    INDEX=0
fi

case "$1" in
    next)
        INDEX=$(( (INDEX + 1) % TOTAL ))
        ;;
    prev)
        INDEX=$(( (INDEX - 1 + TOTAL) % TOTAL ))
        ;;
    *)
        echo "Uso: $0 [next|prev]"
        exit 1
        ;;
esac

echo "$INDEX" > "$STATE_FILE"

pkill swaybg; swaybg -i "${WALLPAPERS[$INDEX]}" -m fill &
