#!/bin/bash
# Docker-Image-Name definieren
IMAGE_NAME="my-nvim"
# Pfad zum Script-Verzeichnis ermitteln
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
# Image erstellen
docker build -t "$IMAGE_NAME" "$SCRIPT_DIR"
# Aktuellen Ordner als /app mounten
# Aktuellen Ordner als /app mounten und Neovim-Cache mounten
docker run -it --rm \
 -v "$(pwd):/app" \
 -v "$SCRIPT_DIR/nvim-cache:/root/.local/share/nvim/site/pack" \
 "$IMAGE_NAME" nvim
