#!/usr/bin/env bash
set -euo pipefail
ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
IMAGE_TAG="${IMAGE_TAG:-1.0.0}"
docker build -t argo-rollouts-demo:${IMAGE_TAG} "$ROOT_DIR/app"
kind load docker-image argo-rollouts-demo:${IMAGE_TAG} --name argo-rollouts-demo
