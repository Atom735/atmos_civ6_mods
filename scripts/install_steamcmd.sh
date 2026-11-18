#!/usr/bin/env bash
set -euo pipefail

ROOT="$(cd "$(dirname "$0")/.." && pwd)"
STEAMCMD_DIR="${STEAMCMD_DIR:-$ROOT/.steamcmd}"

mkdir -p "$STEAMCMD_DIR"
cd "$STEAMCMD_DIR"

if [[ ! -x "$STEAMCMD_DIR/steamcmd.sh" ]]; then
  echo "Downloading SteamCMD for macOS..."
  curl -fsSL "https://steamcdn-a.akamaihd.net/client/installer/steamcmd_osx.tar.gz" -o steamcmd_osx.tar.gz
  tar -xzf steamcmd_osx.tar.gz
  rm -f steamcmd_osx.tar.gz
fi

echo "Updating SteamCMD..."
"$STEAMCMD_DIR/steamcmd.sh" +quit

echo
echo "SteamCMD ready:"
echo "  $STEAMCMD_DIR/steamcmd.sh"
