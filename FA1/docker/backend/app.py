"""
FA1 Backend API Service (Container 2)
Lightweight REST API providing health checks, status, and environment metadata.
"""

import os
import socket
import datetime
from flask import Flask, jsonify
from flask_cors import CORS

app = Flask(__name__)
CORS(app)

ENVIRONMENT = os.getenv("ENVIRONMENT", "qa")
APP_VERSION = os.getenv("APP_VERSION", "1.0.0")

@app.route("/api/status", methods=["GET"])
def get_status():
    return jsonify({
        "status": "healthy",
        "service": "Backend-API",
        "environment": ENVIRONMENT,
        "version": APP_VERSION,
        "container_id": socket.gethostname(),
        "timestamp": datetime.datetime.now(datetime.timezone.utc).isoformat()
    })

@app.route("/api/data", methods=["GET"])
def get_data():
    return jsonify({
        "items": [
            {"id": 101, "name": "Container 1 (Frontend)", "technology": "Nginx / Alpine", "status": "Active"},
            {"id": 102, "name": "Container 2 (Backend)", "technology": "Python 3.12 / Flask", "status": "Active"},
            {"id": 103, "name": "IaC Provisioner", "technology": "HashiCorp Terraform", "status": "Managed"},
            {"id": 104, "name": "Target Environment", "technology": ENVIRONMENT.upper(), "status": "Configured"}
        ],
        "environment": ENVIRONMENT
    })

if __name__ == "__main__":
    port = int(os.getenv("PORT", 5000))
    app.run(host="0.0.0.0", port=port)
