# OpenClaw NVIDIA — SUSE BCI variant

NemoClaw sandbox image identical in function to
[`sandboxes/openclaw-nvidia/`](../openclaw-nvidia/) (NeMoClaw DevX UI
extension, policy-proxy, NVIDIA model selector, Deploy modal, API Keys
page, contextual nudges, runtime API-key injection) — but layered on the
SUSE-hardened [`openclaw-suse`](../openclaw-suse/) base instead of the
upstream Ubuntu [`openclaw`](../openclaw/) base.

## Layering

```
suse              (SUSE BCI 16 foundational sandbox — sandboxes/suse/)
  └── openclaw-suse   (adds OpenClaw CLI on SUSE)
        └── openclaw-nvidia-suse   ← THIS IMAGE
              ├── + jq (zypper, not apt)
              ├── + NeMoClaw DevX UI extension
              ├── + policy-proxy (with NVIDIA inference injection)
              └── + per-conversation NVIDIA API-key plumbing
```

## What differs from `openclaw-nvidia/`

| Aspect | `openclaw-nvidia/` (Ubuntu) | `openclaw-nvidia-suse/` (this) |
|---|---|---|
| Default `BASE_IMAGE` | `ghcr.io/nvidia/openshell-community/sandboxes/openclaw:latest` | `ghcr.io/alessandro-festa/openshell-community/sandboxes/openclaw-suse:latest` |
| `jq` install | `apt-get install -y --no-install-recommends jq` | `zypper --non-interactive install -y --no-recommends jq` |
| Everything else | — | identical (same start script, policy-proxy, ncp-logos, nemoclaw-ui-extension, proto, skills, policy.yaml) |

The runtime behaviour, environment variables, ports, NVIDIA API surface,
and policy semantics are the same — see
[`../openclaw-nvidia/README.md`](../openclaw-nvidia/README.md) for the
full feature list, env-var reference, and inference-options docs.

## Build

```bash
docker buildx build \
  --build-arg BASE_IMAGE=ghcr.io/alessandro-festa/openshell-community/sandboxes/openclaw-suse:latest \
  -t openclaw-nvidia-suse:test \
  sandboxes/openclaw-nvidia-suse/
```

CI publishes signed images to
`ghcr.io/alessandro-festa/openshell-community/sandboxes/openclaw-nvidia-suse`
on tags matching `openclaw-nvidia-suse/v*.*.*`.
