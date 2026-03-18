#!/usr/bin/env bash
set -euo pipefail
VERSION="${VERSION:-$(basename $(curl -s -L -o /dev/null -w '%{url_effective}' https://github.com/kubernetes-sigs/cloud-provider-kind/releases/latest))}"
docker rm -f cloud-provider-kind >/dev/null 2>&1 || true
docker run -d --name cloud-provider-kind --rm --network host \
  -v /var/run/docker.sock:/var/run/docker.sock \
  registry.k8s.io/cloud-provider-kind/cloud-controller-manager:${VERSION}
echo "cloud-provider-kind version: ${VERSION}"
kubectl get gatewayclass || true
