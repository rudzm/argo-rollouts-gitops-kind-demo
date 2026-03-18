#!/usr/bin/env bash
set -euo pipefail
echo "Argo CD UI: http://localhost:8081"
echo "Grafana UI: http://localhost:3000"
echo "Prometheus UI: http://localhost:9090"
kubectl -n argocd port-forward svc/argocd-server 8081:80 >/tmp/argocd-port-forward.log 2>&1 &
kubectl -n monitoring port-forward svc/kube-prometheus-stack-grafana 3000:80 >/tmp/grafana-port-forward.log 2>&1 &
kubectl -n monitoring port-forward svc/kube-prometheus-stack-prometheus 9090:9090 >/tmp/prometheus-port-forward.log 2>&1 &
wait
