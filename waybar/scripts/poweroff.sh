#!/bin/bash

# Asegúrate de tener wofi instalado
choice=$(echo -e "Apagar\nReiniciar\nSuspender\nBloquear\nCerrar sesión" | wofi -d -L 5 -l 5 -W 200 -p "Sistema:")

case "$choice" in
    "Apagar")
        loginctl poweroff
        ;;
    "Reiniciar")
        loginctl reboot
        ;;
    "Suspender")
        swaylock -f --image ~/.wallpapers/wallhaven-zpzqeg.jpg & loginctl suspend
        ;;
    "Bloquear")
        swaylock -f --image ~/.wallpapers/wallhaven-zpzqeg.jpg
        ;;
    "Cerrar sesión")
        hyprctl dispatch exit
        ;;
esac