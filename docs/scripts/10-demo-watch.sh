#!/usr/bin/env bash
set -euo pipefail
watch -n 2 '
  echo "=== Rollout ===";
  kubectl argo rollouts get rollout demo-app -n demo;
  echo;
  echo "=== HTTPRoute Weights ===";
  kubectl get httproute demo-route -n demo -o yaml | sed -n "/backendRefs:/,/matches:/p";
  echo;
  echo "=== Pods ===";
  kubectl get pods -n demo -L rollouts-pod-template-hash;
'
