# Alpine als Basis-Image verwenden
FROM alpine:latest
# Neovim und Python installieren
RUN apk add --no-cache neovim python3 py3-pip py3-pynvim git xclip
# Neovim-Konfiguration aus dem aktuellen Verzeichnis kopieren
COPY . /root/.config/nvim
# Arbeitsverzeichnis setzen
RUN mkdir /app
WORKDIR /app
# Neovim starten (optional)
# CMD ["nvim"]
