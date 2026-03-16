# NemoClaw for OpenClaw

Use NemoClaw through OpenClaw to drive OpenShell-backed sandbox workflows.
This launchable is opinionated toward OpenClaw as the primary interface and
OpenShell as the runtime beneath it.

## Launchable Flow

When this Brev launchable completes host setup, it opens `code-server` and
starts an interactive terminal that runs:

```bash
cd /home/ubuntu/openshell-openclaw-plugin
bash ./install.sh
```

That installer is the maintained setup path from the plugin repo. Complete the
interactive onboarding there. The patched upstream onboarding flow now starts
the actual in-sandbox OpenClaw gateway behind the forwarded `127.0.0.1:18789`
listener.

## Manual Install

If you want to run the plugin installer yourself later, use the checkout
created by `brev/launch-plugin.sh`:

```bash
cd /home/ubuntu/openshell-openclaw-plugin
bash ./install.sh
```

Public GitHub checkout:

```bash
cd /home/ubuntu
git clone https://github.com/NVIDIA/openshell-openclaw-plugin.git
cd /home/ubuntu/openshell-openclaw-plugin
bash ./install.sh
```

Private GitHub checkout:

```bash
cd /home/ubuntu
git clone https://x-access-token:${GITHUB_TOKEN}@github.com/NVIDIA/openshell-openclaw-plugin.git
cd /home/ubuntu/openshell-openclaw-plugin
bash ./install.sh
```

## OpenClaw Commands

| Command | Description |
|---------|-------------|
| `openclaw nemoclaw launch` | Fresh install into OpenShell (warns net-new users) |
| `openclaw nemoclaw migrate` | Migrate host OpenClaw into sandbox (snapshot + cutover) |
| `openclaw nemoclaw connect` | Interactive shell into the sandbox |
| `openclaw nemoclaw status` | Blueprint state, sandbox health, inference config |
| `openclaw nemoclaw eject` | Rollback to host installation from snapshot |
| `openclaw nemoclaw onboard` | Interactive onboarding for API key, endpoint, and model selection |
| `/nemoclaw` | Slash command in chat (status, eject) |

## Usage

### Connect to the sandbox

```bash
nemoclaw connect                # local
nemoclaw connect my-gpu-box     # remote Brev instance
```

### Run OpenClaw (inside the sandbox)

```bash
openclaw agent --agent main --local -m "your prompt" --session-id s1
```

### Switch inference providers

```bash
# NVIDIA cloud (Nemotron 3 Super 120B)
openshell inference set --provider nvidia-nim --model nvidia/nemotron-3-super-120b-a12b

# Local vLLM
openshell inference set --provider vllm-local --model nvidia/nemotron-3-nano-30b-a3b
```

### Monitor

```bash
openshell term
```
