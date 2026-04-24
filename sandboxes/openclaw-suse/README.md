# SPDX-FileCopyrightText: Copyright (c) 2026 SUSE LLC. All rights reserved.
# SPDX-License-Identifier: Apache-2.0

# OpenClaw Sandbox — SUSE BCI 16 Variant

This sandbox image extends the SUSE BCI base sandbox (`sandboxes/suse/`) with
[OpenClaw](https://openclaw.ai), providing the same user experience as
`sandboxes/openclaw/` but on a SUSE Linux Enterprise BCI 16 foundation.

## What it adds over the SUSE base

| Addition | Detail |
|---|---|
| `openclaw` CLI | Pinned release installed via npm |
| `/etc/openshell/policy.yaml` | Default egress policy for OpenClaw |
| `/usr/local/bin/openclaw-start` | Startup helper script |
| `/sandbox/.openclaw/` | OpenClaw workspace directory |

## Build

```sh
# Using the SUSE base image from our registry
docker build \
  --build-arg BASE_IMAGE=ghcr.io/<your-org>/openshell-community/sandboxes/suse:latest \
  -t openshell-openclaw-suse \
  sandboxes/openclaw-suse/

# Pin to a digest for fully reproducible builds
docker build \
  --build-arg BASE_IMAGE=ghcr.io/<your-org>/openshell-community/sandboxes/suse@sha256:<digest> \
  -t openshell-openclaw-suse \
  sandboxes/openclaw-suse/
```

## Relationship to other sandboxes

| Sandbox | Base OS | Purpose |
|---|---|---|
| `sandboxes/base/` | Ubuntu Noble | Upstream community base |
| `sandboxes/openclaw/` | Ubuntu Noble (via base) | Upstream OpenClaw sandbox |
| `sandboxes/suse/` | SLE BCI 16 | SUSE base (this repo's fork) |
| `sandboxes/openclaw-suse/` | SLE BCI 16 (via suse) | **This image** |

## Maintenance

This image is maintained by the SUSE AI Factory team and is not submitted
upstream to NVIDIA/OpenShell-Community (hybrid shipping model).
