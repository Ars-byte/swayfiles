#!/bin/bash

# Asegurar que el script sepa dónde está la sesión de Wayland
export XDG_RUNTIME_DIR=/run/user/$(id -u)

# Capturar y copiar (silenciando errores de notificación por ahora)
if grim -g "$(slurp)" - | wl-copy; then
    # Intentar enviar notificación, pero si falla que no detenga el script
    notify-send "Captura" "Copiada al portapapeles" -i camera-photo || echo "Copiado (notificación no disponible)"
else
    echo "Error: ¿Has cancelado la selección o falta alguna dependencia?"
fi
