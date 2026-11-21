# Droid - Claude Code

Run Claude Code in isolated per-project Docker containers using your existing Claude
Pro/Max subscription, with no API key required.

The token is stored in the macOS Keychain (encrypted at rest, Touch ID / login password
protected) and never written to disk as a plain file. It is retrieved at runtime,
passed to the container via Docker secrets, and wiped from the filesystem when the
session ends.

## Prerequisites

- macOS (Keychain integration)
- Docker and Docker Compose installed
- Claude Code installed on your **host** machine
- An active Claude Pro or Max subscription

## Step 1 — Build the base image (once)

```bash
docker build -t droid-claude ~/.config/droid/docker
```

You only need to rebuild when you want to update Claude Code itself.

## Step 2 — Generate your OAuth token and store it in Keychain (once)

Run this on your host machine where a browser is available:

```bash
claude setup-token
```

A browser window will open. Log in with your Claude account. Once authenticated, the
CLI prints a long-lived token:

```
sk-ant-oat01-xxxx...
```

> **Important:** copy it immediately — you will not see it again.

Store it directly in the macOS Keychain (no plain file on disk):

```bash
security add-generic-password \
  -a "claude-code" \
  -s "claude-oauth-token" \
  -w "sk-ant-oat01-xxxx..."
```

You can verify it was stored correctly with:

```bash
security find-generic-password -a "claude-code" -s "claude-oauth-token" -w
```

The token is valid for approximately one year. When it expires, update the Keychain entry:

```bash
security delete-generic-password -a "claude-code" -s "claude-oauth-token"
security add-generic-password -a "claude-code" -s "claude-oauth-token" -w "sk-ant-oat01-newtoken..."
```

## Step 3 — Add a `.droid.compose.yml` to a project

Add a `.droid.compose.yml` file with

```bash
droid add [--name project-name]
```

You can create one or more `.droid.compose.yml` files. Each one will launch a separated
instance with isolated context. 

In each file, you can edit the directories that will be exposed to Claude Code under
the `volumes` field of the `claude` service.

```
~/projects/
├── project-a/
│   ├── .droid.compose.yml
│   └── src/
├── project-b/
│   ├── .droid.compose.yml
│   └── src/
```

By default, the whole project folder is exposed via the `./:/workspace` mapping.

Each project gets its own `droid-claude-home` named volume, so sessions, history, and credentials
are fully isolated between projects.

## Step 4 — Start a session

Always use `droid` instead of calling `docker compose` directly:

```bash
droid [...args]
```

For a one-shot non-interactive task:

```bash
droid -p "write tests for all untested functions"
```

## Updating Claude Code

Claude Code is baked into the Docker image at build time and pinned there (`DISABLE_AUTOUPDATER=1`).
Each project's volume then holds its own copy of the binary, so updates are not automatic.

**New projects** — rebuilding the image (see Step 1) is enough. Fresh volumes are
seeded from the new image on first run.

**Existing projects** — rebuilding the image has no effect on volumes that already
exist. Update each project you care about by running this from the project directory:

```bash
droid shell -c 'claude update'
```

This updates the binary inside the project's volume without touching conversations
or history.

## Re-authenticating

If your token expires or you see a `401` error:

1. On your host, run `claude setup-token` again and copy the new token
2. Replace the Keychain entry:
   ```bash
   security delete-generic-password -a "claude-code" -s "claude-oauth-token"
   security add-generic-password -a "claude-code" -s "claude-oauth-token" -w "sk-ant-oat01-newtoken..."
   ```
3. Start a new session with `droid` — no rebuild needed

