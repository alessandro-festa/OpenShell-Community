# syntax=docker/dockerfile:1.4

# SPDX-FileCopyrightText: Copyright (c) 2026 SUSE LLC. All rights reserved.
# SPDX-License-Identifier: Apache-2.0

# OpenClaw sandbox — SUSE BCI 16 variant
#
# Builds on the SUSE BCI base sandbox (sandboxes/suse/) and adds OpenClaw,
# identical in function to sandboxes/openclaw/ but on a SUSE foundation.
#
# Build:
#   docker build \
#     --build-arg BASE_IMAGE=ghcr.io/<org>/openshell-community/sandboxes/suse:latest \
#     -t openshell-openclaw-suse .
#
# Or pin to a digest for reproducible builds:
#   docker build \
#     --build-arg BASE_IMAGE=ghcr.io/<org>/openshell-community/sandboxes/suse@sha256:<digest> \
#     -t openshell-openclaw-suse .

ARG BASE_IMAGE=ghcr.io/nvidia/openshell-community/sandboxes/suse:latest
FROM ${BASE_IMAGE}

USER root

# Install OpenClaw CLI (pinned to fix GHSA-rchv-x836-w7xp, GHSA-6mgf-v5j7-45cr,
# GHSA-5wcw-8jjv-m286)
RUN npm install -g openclaw@2026.3.11

# Copy sandbox policy
COPY policy.yaml /etc/openshell/policy.yaml

# Copy the OpenClaw startup helper
COPY openclaw-start.sh /usr/local/bin/openclaw-start
RUN chmod +x /usr/local/bin/openclaw-start

# Create OpenClaw workspace
RUN mkdir -p /sandbox/.openclaw && \
    chown -R sandbox:sandbox /sandbox/.openclaw

USER sandbox

ENTRYPOINT ["/bin/bash"]
