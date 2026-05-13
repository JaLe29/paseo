FROM node:20-slim

# Instalace Paseo a Claude Code (globální CLI; příkaz `claude` v PATH)
RUN npm install -g @getpaseo/cli @anthropic-ai/claude-code

# Vytvoření pracovního adresáře
WORKDIR /app

# Bezrootový uživatel app (UID/GID 1001)
RUN groupadd --system --gid 1001 app \
	&& useradd --system --uid 1001 --gid app --create-home app \
	&& chown -R app:app /app

USER app

EXPOSE 6767

# Spouštěcí skript:
# 1. Spustí paseo (aby se provedlo při startu)
# 2. Pak spustí nekonečné čekání, které udrží kontejner naživu
ENTRYPOINT ["/bin/sh", "-c", "paseo && tail -f /dev/null"]