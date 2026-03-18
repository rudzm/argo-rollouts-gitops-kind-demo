#!/usr/bin/env bash
set -euo pipefail
ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
REPO_URL="${REPO_URL:-https://github.com/rudzm/argo-rollouts-gitops-kind-demo.git}"
TMP_FILE="$(mktemp)"
sed "s#https://github.com/rudzm/argo-rollouts-gitops-kind-demo.git#${REPO_URL}#g" \
  "$ROOT_DIR/argocd-apps/demo-app.yaml" > "$TMP_FILE"
kubectl apply -f "$TMP_FILE"
rm -f "$TMP_FILE"
