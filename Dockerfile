FROM node:20-slim

# Instalace Paseo a Claude Code (globální CLI; příkaz `claude` v PATH)
RUN npm install -g @getpaseo/cli @anthropic-ai/claude-code

RUN apt-get update && apt-get install -y socat && rm -rf /var/lib/apt/lists/*

# Vytvoření pracovního adresáře
WORKDIR /app

# Bezrootový uživatel app (UID/GID 1001)
RUN groupadd --system --gid 1001 app \
	&& useradd --system --uid 1001 --gid app --create-home app \
	&& chown -R app:app /app

USER app

EXPOSE 6666

# Paseo daemon naslouchá jen na 127.0.0.1:6767, socat přeposílá provoz z 0.0.0.0:6666
ENTRYPOINT ["/bin/sh", "-c", "paseo && socat TCP-LISTEN:6666,bind=0.0.0.0,fork TCP:127.0.0.1:6767"]