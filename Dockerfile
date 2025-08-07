# Alpine als Basis-Image verwenden
FROM alpine:latest
# Neovim und Python installieren
RUN apk add --no-cache neovim neovim-doc python3 py3-pip py3-pynvim git xclip fzf grep
# Neovim-Konfiguration aus dem aktuellen Verzeichnis kopieren
COPY . /root/.config/nvim
# Arbeitsverzeichnis setzen
RUN mkdir /app
RUN git config --global --add safe.directory /app
WORKDIR /app
