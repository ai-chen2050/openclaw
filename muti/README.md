This directory contains example multi-instance configurations for OpenClaw.

- `quant/`: opinionated setup for a **quant trading bot** agent.
- `creator/`: opinionated setup for a **content / social media** agent.
- `support/`: customer support / ticket triage assistant.
- `reviewer/`: code review / PR assistant.

Each subfolder includes:

- `docker-compose.yml`: single-instance gateway + CLI wired to its own config/workspace volumes.
- `env.example`: environment variables you can copy to `.env`.
- `workspace/`: prefilled agent workspace markdown (IDENTITY, SOUL, TOOLS, AGENTS, USER).
- `config/openclaw.json`: minimal channel config (includes `channels.telegram.groups` allowlist).

Quick usage (example for an instance):

1. `cd muti/quant` (or `muti/creator`, `muti/support`, `muti/reviewer`)
2. `cp env.example .env` and fill in API keys / tokens (set `TELEGRAM_BOT_TOKEN` for Telegram bots).
3. `docker compose up -d openclaw-gateway`
4. `docker compose run --rm openclaw-cli status --all`

Telegram pairing (per instance)

Each instance is preconfigured to accept a default Telegram group (`-1003897330654`) via `config/openclaw.json`.
To add the Telegram bot for an instance and enable pairing, set `TELEGRAM_BOT_TOKEN` in that instance's `.env` and run the helper from the instance folder:

```bash
# from the instance folder, e.g. muti/quant
cp env.example .env
# edit .env and set TELEGRAM_BOT_TOKEN
docker compose up -d openclaw-gateway
docker compose run --rm openclaw-cli bash ./telegram-setup.sh
```

After the command finishes:

- DM the bot (or add it to the group `-1003897330654`) and follow the pairing prompt to approve.
- If you want the bot to respond without an `@` mention, edit `config/openclaw.json` and set `requireMention: false` for that group (note: Telegram privacy mode may need adjusting).

Notes

- Each instance uses its own `config` and `workspace` directories so agent memory and identity are isolated.
- Ports used by the example instances: quant `18791`, creator `18792`, support `18793`, reviewer `18794` (change in `env.example` if needed).
- You can duplicate an instance folder to create more specialized agents; ensure ports and config dirs are unique.

Files of interest:

- [muti/telegram-setup.sh](muti/telegram-setup.sh) — helper to add the Telegram channel from the CLI container.
- [muti/quant](muti/quant) — quant trading example.
- [muti/creator](muti/creator) — content creator example.
- [muti/support](muti/support) — support/ticket assistant.
- [muti/reviewer](muti/reviewer) — code review assistant.

If you want, I can also add per-instance examples for `channels.telegram.groups` that disable mention gating or allow multiple group IDs.
