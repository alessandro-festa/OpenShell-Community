# SPDX-FileCopyrightText: Copyright (c) 2026 SUSE LLC. All rights reserved.
# SPDX-License-Identifier: Apache-2.0
#
# Helper Makefile for local SUSE sandbox development.
# Credentials are NEVER stored in this file; load them from an external path.

.PHONY: dev-creds help

help:
	@echo "SUSE AI Factory — OpenShell Community Makefile"
	@echo ""
	@echo "Targets:"
	@echo "  make dev-creds CREDS=<path>   Load SUSE Application Collection env vars"
	@echo "                                from <path> (e.g. ~/.config/suse-aif/creds)."
	@echo "                                The file must export APP_COLLECTION_USER and"
	@echo "                                APP_COLLECTION_TOKEN. Never commit that file."
	@echo ""
	@echo "  make help                     Show this message."

# Load SUSE Application Collection credentials from an external file and
# validate that the required variables are set.  Usage:
#
#   make dev-creds CREDS=~/.config/suse-aif/creds
#   # then in the same shell:
#   docker build --build-arg BASE_IMAGE=... sandboxes/suse/
#
# The creds file should contain (not committed):
#   export APP_COLLECTION_USER=<user>
#   export APP_COLLECTION_TOKEN=<token>
dev-creds:
	@if [ -z "$(CREDS)" ]; then \
	  echo "ERROR: CREDS path not specified. Run: make dev-creds CREDS=<path>"; \
	  exit 1; \
	fi
	@if [ ! -f "$(CREDS)" ]; then \
	  echo "ERROR: credentials file not found: $(CREDS)"; \
	  exit 1; \
	fi
	@echo "# Run the following in your shell to load credentials:"
	@echo "# (This Makefile cannot export env vars to your shell directly)"
	@echo ""
	@echo "  source $(CREDS)"
	@echo ""
	@echo "# Then verify with: echo \$$APP_COLLECTION_USER"
	@grep -qE '^export APP_COLLECTION_USER=' "$(CREDS)" || \
	  (echo "ERROR: APP_COLLECTION_USER not found in $(CREDS)"; exit 1)
	@grep -qE '^export APP_COLLECTION_TOKEN=' "$(CREDS)" || \
	  (echo "ERROR: APP_COLLECTION_TOKEN not found in $(CREDS)"; exit 1)
	@echo "# Credentials file structure is valid."
