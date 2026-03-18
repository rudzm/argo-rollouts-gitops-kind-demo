#!/usr/bin/env bash
set -euo pipefail
ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
kubectl create namespace argo-rollouts --dry-run=client -o yaml | kubectl apply -f -
kubectl apply -n argo-rollouts -f https://github.com/argoproj/argo-rollouts/releases/latest/download/install.yaml
kubectl apply -f "$ROOT_DIR/bootstrap/argo-rollouts/plugin-configmap.yaml"
kubectl apply -f "$ROOT_DIR/bootstrap/argo-rollouts/gateway-rbac.yaml"
kubectl rollout restart deployment argo-rollouts -n argo-rollouts
kubectl rollout status deployment argo-rollouts -n argo-rollouts --timeout=180s
