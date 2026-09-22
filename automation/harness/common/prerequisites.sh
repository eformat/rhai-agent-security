#!/bin/bash
# Pre-flight check for agent-harness-in-a-box demos.
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
# shellcheck source=functions.sh
source "$SCRIPT_DIR/functions.sh"

echo "============================================"
echo " Agent Harness in a Box - Pre-flight Check"
echo "============================================"
echo ""

check_prereqs

echo ""
info "Cluster: $(oc whoami --show-server)"
info "User:    $(oc whoami)"
info "Domain:  $(detect_apps_domain)"
echo ""

# Check for the exact workshop CLI.
EXPECTED_OPENSHELL_VERSION="${OPENSHELL_VERSION:-0.0.103}"
if ! command -v openshell &>/dev/null; then
    error "openshell CLI not found. Run automation/bootstrap/install-openshell-cli.sh."
    exit 1
fi
ACTUAL_OPENSHELL_VERSION=$(openshell --version | awk '{print $NF}')
if [ "$ACTUAL_OPENSHELL_VERSION" != "$EXPECTED_OPENSHELL_VERSION" ]; then
    error "openshell CLI must be $EXPECTED_OPENSHELL_VERSION; found $ACTUAL_OPENSHELL_VERSION"
    exit 1
fi
info "openshell CLI: $ACTUAL_OPENSHELL_VERSION"

# Check storage
DEFAULT_STORAGE_CLASS=$(oc get sc -o jsonpath='{.items[?(@.metadata.annotations.storageclass\.kubernetes\.io/is-default-class=="true")].metadata.name}' 2>/dev/null || true)
if [ -z "$DEFAULT_STORAGE_CLASS" ]; then
    error "No default StorageClass found. OpenShell gateway requires a 1Gi PVC."
    exit 1
fi
info "Default StorageClass: $DEFAULT_STORAGE_CLASS"

echo ""
info "All checks passed. Ready to run demos."
