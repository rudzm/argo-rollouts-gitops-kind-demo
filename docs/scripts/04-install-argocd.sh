#!/usr/bin/env bash
set -euo pipefail

NAMESPACE="argocd"
ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
helm repo add argo https://argoproj.github.io/argo-helm >/dev/null
helm repo update >/dev/null

helm upgrade --install argocd argo/argo-cd \
  --namespace argocd \
  --create-namespace \
  -f "$ROOT_DIR/bootstrap/argocd/argocd-values.yaml" \
  --wait

echo "Argo CD installed"
echo "URL: https://localhost:30443"
echo "Initial admin password:"
kubectl -n argocd get secret argocd-initial-admin-secret \
  -o jsonpath="{.data.password}" | base64 -d && echo