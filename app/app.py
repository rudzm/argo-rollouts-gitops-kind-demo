from flask import Flask, Response, jsonify, request
from prometheus_client import Counter, generate_latest, CONTENT_TYPE_LATEST
import os
import random
import socket

app = Flask(__name__)

REQUESTS = Counter('demo_requests_total', 'Total requests', ['version', 'status'])

VERSION = os.getenv('VERSION', 'v1')
ERROR_RATE = float(os.getenv('ERROR_RATE', '0'))
COLOR = os.getenv('COLOR', 'blue')
APP_NAME = os.getenv('APP_NAME', 'argo-rollouts-demo')
HOSTNAME = socket.gethostname()


@app.route('/')
def index():
    fail = random.random() < ERROR_RATE
    status = '500' if fail else '200'
    REQUESTS.labels(version=VERSION, status=status).inc()
    payload = {
        'app': APP_NAME,
        'version': VERSION,
        'color': COLOR,
        'hostname': HOSTNAME,
        'error_rate': ERROR_RATE,
        'path': request.path,
    }
    if fail:
        return jsonify(payload | {'message': 'simulated canary failure'}), 500
    return jsonify(payload | {'message': 'ok'})


@app.route('/healthz')
def healthz():
    return 'ok', 200


@app.route('/metrics')
def metrics():
    return Response(generate_latest(), mimetype=CONTENT_TYPE_LATEST)


if __name__ == '__main__':
    app.run(host='0.0.0.0', port=8080)
