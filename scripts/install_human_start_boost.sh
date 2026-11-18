#!/usr/bin/env bash
set -euo pipefail

ROOT="$(cd "$(dirname "$0")/.." && pwd)"
SRC="$ROOT/atmos_human_start_boost"
DEST_DIR="$HOME/Library/Application Support/Sid Meier's Civilization VI/Sid Meier's Civilization VI/Mods"
DEST="$DEST_DIR/atmos_human_start_boost"

if [[ ! -d "$SRC" ]]; then
  echo "Source mod not found: $SRC" >&2
  exit 1
fi

mkdir -p "$DEST_DIR"
rm -rf "$DEST"
cp -R "$SRC" "$DEST"

echo "Installed to:"
echo "  $DEST"
echo
echo "Next:"
echo "  1) Disable old mods: Extra Starting Settler, Sight Enhance, Move +2, First Settler, ..."
echo "  2) Enable: Atmos: Human Start Boost"
echo "  3) Create Game → Advanced Setup → set sliders"
