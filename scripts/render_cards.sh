#!/usr/bin/env bash
set -euo pipefail

HTML="${1:-}"
if [ -z "$HTML" ] || [ ! -f "$HTML" ]; then
  echo "Usage: render_cards.sh /path/to/index.html" >&2
  exit 1
fi

CHROME="${CHROME:-/Applications/Google Chrome.app/Contents/MacOS/Google Chrome}"
if [ ! -x "$CHROME" ]; then
  CHROME="$(command -v google-chrome || command -v chromium || command -v chromium-browser || true)"
fi
if [ -z "$CHROME" ] || [ ! -x "$CHROME" ]; then
  echo "Chrome/Chromium not found. Set CHROME=/path/to/chrome." >&2
  exit 1
fi

HTML_ABS="$(cd "$(dirname "$HTML")" && pwd)/$(basename "$HTML")"
OUT_DIR="$(dirname "$HTML_ABS")/output"
mkdir -p "$OUT_DIR"

COUNT="$("$CHROME" --headless=new --disable-gpu --dump-dom "file://$HTML_ABS" 2>/dev/null | grep -Eo 'class="[^"]*(wechat-cover|wechat-slide)[^"]*"' | wc -l | tr -d ' ')"
if [ "$COUNT" = "0" ]; then
  echo "No .wechat-cover or .wechat-slide cards found in $HTML_ABS" >&2
  exit 1
fi

BODY_IMAGES=()

for ((i=0; i<COUNT; i++)); do
  if [ "$i" = "0" ]; then
    SIZE="2100,900"
    OUT="$OUT_DIR/00-cover-21x9.png"
  else
    SIZE="1080,1440"
    OUT="$OUT_DIR/$(printf "%02d-card.png" "$i")"
    BODY_IMAGES+=("$OUT")
  fi
  "$CHROME" \
    --headless=new \
    --disable-gpu \
    --hide-scrollbars \
    --force-device-scale-factor=1 \
    --window-size="$SIZE" \
    --screenshot="$OUT" \
    "file://$HTML_ABS?slide=$i" >/dev/null 2>&1
  echo "Wrote $OUT"
done

if command -v magick >/dev/null 2>&1 && [ "${#BODY_IMAGES[@]}" -gt 1 ]; then
  LONG_OUT="$OUT_DIR/body-long.png"
  magick "${BODY_IMAGES[@]}" -append "$LONG_OUT"
  echo "Wrote $LONG_OUT"
fi
