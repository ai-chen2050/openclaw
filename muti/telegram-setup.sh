#!/usr/bin/env bash
set -euo pipefail

# Simple helper to add a Telegram channel for the current instance.
# Usage (from an instance folder, e.g. muti/quant):
#   cp env.example .env && edit it
#   docker compose run --rm openclaw-cli bash ./telegram-setup.sh

if [[ -z "${TELEGRAM_BOT_TOKEN:-}" ]]; then
  echo "TELEGRAM_BOT_TOKEN is empty; set it in .env first" >&2
  exit 1
fi

echo "Using TELEGRAM_BOT_TOKEN from environment to add Telegram channel..."

node dist/index.js channels add \
  --channel telegram \
  --token "$TELEGRAM_BOT_TOKEN"

echo
echo "Done. Next steps (inside Telegram):"
echo "1) DM the bot, approve pairing when prompted."
echo "2) Or add the bot to a group and @ 它 触发对话。"
