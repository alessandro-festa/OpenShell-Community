# SPDX-FileCopyrightText: Copyright (c) 2026 SUSE LLC. All rights reserved.
# SPDX-License-Identifier: Apache-2.0

# SUSE Sandbox

A SUSE Linux Enterprise BCI variant of the OpenShell Community base sandbox image.
This image provides the same foundational system tools, users, and developer environment
as [`sandboxes/base/`](../base/) but is built on `registry.suse.com/bci/bci-base:16.0`
and managed with `zypper` instead of `apt-get`.

The `bci-base:16.0` image is freely available — no SUSE subscription or registry
credentials are required to pull it.

## Differences from the Ubuntu Base

| Aspect | Ubuntu base (`sandboxes/base/`) | This image (`sandboxes/base-suse/`) |
|--------|--------------------------------|--------------------------------------|
| Base image | `nvcr.io/nvidia/base/ubuntu:noble-20251013` | `registry.suse.com/bci/bci-base:16.0` |
| Package manager | `apt-get` | `zypper` |
| DNS tools package | `dnsutils` | `bind-utils` |
| SSH / SFTP package | `openssh-sftp-server` | `openssh` (includes sftp-server) |
| Ping package | `iputils-ping` | `iputils` |
| Maintenance | NVIDIA / OpenShell Community | SUSE AI Factory |

All other capabilities — users, Python (via `uv`), Node.js, agent CLIs, GitHub CLI,
Claude CLI, directory layout, and sandbox policy — are identical to the Ubuntu base.

## What's Included

| Category | Tools |
|----------|-------|
| OS | SUSE Linux Enterprise BCI 16.0 |
| Languages | `python3` (3.13), `node` (22.x) |
| Package managers | `npm` (11.11.0), `uv` (0.10.8), `pip` |
| Coding agents | `claude`, `opencode`, `codex`, `copilot` |
| Developer | `gh`, `git`, `vim`, `nano` |
| Networking | `ping`, `dig`, `nslookup`, `nc`, `traceroute`, `netstat`, `curl` |

### Users

| User | Purpose |
|------|---------|
| `supervisor` | Privileged process management (nologin shell) |
| `sandbox` | Unprivileged user for agent workloads (default) |

### Directory Layout

```
/sandbox/                  # Home directory (sandbox user)
  .bashrc, .profile        # Shell init (PATH, VIRTUAL_ENV, UV_PYTHON_INSTALL_DIR)
  .venv/                   # Writable Python venv (pip install, uv pip install)
  .agents/skills/          # Agent skill discovery
  .claude/skills/          # Claude skill discovery (symlinked from .agents/skills)
```

## Build

```bash
docker build -t openshell-base-suse .
```

## Building a Sandbox on Top

```dockerfile
ARG BASE_IMAGE=openshell-base-suse:latest
FROM ${BASE_IMAGE}

# Add your sandbox-specific layers here
```

## Maintenance

This variant is maintained by **SUSE AI Factory** as part of the
[SUSE AI Factory with NVIDIA](https://github.com/suse/aif-nc) project.

Upstream OpenShell Community contributions use the Ubuntu-based image at
`sandboxes/base/`. If you are contributing back to NVIDIA/OpenShell-Community,
target that image. Use this SUSE BCI variant when deploying on SUSE-based
infrastructure or when a SUSE-certified base is required.
