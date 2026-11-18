#!/usr/bin/env bash
set -euo pipefail

ROOT="$(cd "$(dirname "$0")/.." && pwd)"
STEAMCMD_DIR="${STEAMCMD_DIR:-$ROOT/.steamcmd}"
STEAMCMD="$STEAMCMD_DIR/steamcmd.sh"
# Civ 6: previewfile via steamcmd usually fails (LegacyCloud Access Denied).
# Default publishes content + metadata only.
VDF="${VDF:-$ROOT/workshop/upload_meta.vdf}"
CONTENT="$ROOT/atmos_human_start_boost"

if [[ ! -f "$VDF" ]]; then
  echo "Missing $VDF" >&2
  exit 1
fi
if [[ ! -f "$CONTENT/AtmosHumanStartBoost.modinfo" ]]; then
  echo "Missing mod content: $CONTENT" >&2
  exit 1
fi
if [[ ! -x "$STEAMCMD" ]]; then
  echo "SteamCMD not found. Run: ./scripts/install_steamcmd.sh" >&2
  exit 1
fi

if grep -q 'previewfile' "$VDF"; then
  echo "WARNING: $VDF contains previewfile — Civ 6 often returns Access Denied on preview." >&2
fi

STEAM_USER="${STEAM_USER:-atom735_2012}"

echo "Uploading workshop item via SteamCMD..."
echo "  content: $CONTENT"
echo "  vdf:     $VDF"
echo "  item:    https://steamcommunity.com/sharedfiles/filedetails/?id=3842173946"
echo

"$STEAMCMD" +login "$STEAM_USER" +workshop_build_item "$VDF" +quit

echo
echo "Done."
echo "Preview still needs to be set in Workshop web UI (steamcmd cannot for Civ 6):"
echo "  https://steamcommunity.com/sharedfiles/filedetails/?id=3842173946"
echo "  Use: $ROOT/workshop/preview_small.jpg"
echo "Then change visibility to Public."
