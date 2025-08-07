#!/bin/bash

# Docker/Podman-Image-Name definieren
IMAGE_NAME="my-nvim"

# Pfad zum Script-Verzeichnis ermitteln
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Überprüfen, ob Podman installiert ist
if command -v podman &> /dev/null; then
  CONTAINER_CMD="podman"
else
  CONTAINER_CMD="docker"
fi

# Image erstellen
$CONTAINER_CMD build -t "$IMAGE_NAME" "$SCRIPT_DIR"

# Sicherstellen, dass der Neovim-Cache-Ordner existiert
NVIM_CACHE_DIR="$HOME/.cache/nvim_cache"
mkdir -p "$NVIM_CACHE_DIR"

# Aktuellen Ordner als /app mounten und Neovim-Cache mounten
$CONTAINER_CMD run -it --rm \
  -v "$(pwd):/app" \
  -v "$NVIM_CACHE_DIR:/root/.local/share/nvim/site/pack" \
  "$IMAGE_NAME" nvim
