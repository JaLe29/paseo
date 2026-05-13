# paseo-docker

Docker port of [paseo](https://github.com/getpaseo/paseo) — a self-hosted web UI for Claude Code.

## Usage

```bash
docker run -d \
  -e CLAUDE_CODE_OAUTH_TOKEN='xxxx' \
  -p 6666:6666 \
  --name paseo \
  jaledeveloper/paseo:sha-bc2f4f9
```

Replace `xxxx` with your Claude OAuth token. The UI will be available at [http://localhost:6666](http://localhost:6666).

## Environment variables

| Variable | Required | Description |
|---|---|---|
| `CLAUDE_CODE_OAUTH_TOKEN` | yes | Claude OAuth token used to authenticate with the API |

## How it works

The container runs the `paseo` daemon (which listens on `127.0.0.1:6767`) and uses `socat` to forward traffic from `0.0.0.0:6666` to it, making the UI accessible from outside the container.
