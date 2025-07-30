# Alpine als Basis-Image verwenden
FROM alpine:latest
# Neovim und Python installieren
RUN apk add --no-cache neovim python3 py3-pip
# Python-Abhängigkeiten für Neovim installieren
RUN pip3 install --no-cache-dir pynvim
# Neovim-Konfiguration aus dem aktuellen Verzeichnis kopieren
COPY . /root/.config/nvim
# Arbeitsverzeichnis setzen
WORKDIR /root
# Neovim starten (optional)
# CMD ["nvim"]
