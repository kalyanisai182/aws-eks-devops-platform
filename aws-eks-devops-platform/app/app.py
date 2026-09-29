"""Small Flask service used to demonstrate the CI/CD + EKS pipeline."""
import os
import time

from flask import Flask, jsonify, request
from prometheus_client import CONTENT_TYPE_LATEST, Counter, Histogram, generate_latest

app = Flask(__name__)

REQUESTS = Counter("app_requests_total", "Total HTTP requests", ["method", "endpoint", "status"])
LATENCY = Histogram("app_request_latency_seconds", "Request latency in seconds", ["endpoint"])

VERSION = os.getenv("APP_VERSION", "dev")


@app.before_request
def _start_timer():
    request._start = time.perf_counter()


@app.after_request
def _record_metrics(response):
    if request.path != "/metrics":
        elapsed = time.perf_counter() - getattr(request, "_start", time.perf_counter())
        LATENCY.labels(request.path).observe(elapsed)
        REQUESTS.labels(request.method, request.path, response.status_code).inc()
    return response


@app.route("/")
def index():
    return jsonify(message="Hello from the AWS EKS DevOps platform", version=VERSION)


@app.route("/health")
def health():
    return jsonify(status="ok"), 200


@app.route("/metrics")
def metrics():
    return generate_latest(), 200, {"Content-Type": CONTENT_TYPE_LATEST}


if __name__ == "__main__":
    app.run(host="0.0.0.0", port=int(os.getenv("PORT", "8080")))
