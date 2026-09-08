"""
DevOps Lab Assignment 4 - Containerized Python Web Application
Demonstrating Docker containerization and Docker Compose multi-service management.
"""

import os
import socket
import datetime
from flask import Flask, jsonify

app = Flask(__name__)

@app.route("/")
def home():
    return jsonify({
        "status": "success",
        "message": "Hello from Docker Containerized Python Web Service!",
        "service": "DevOps-Flask-Service",
        "environment": os.getenv("APP_ENV", "production"),
        "container_hostname": socket.gethostname(),
        "timestamp": datetime.datetime.now(datetime.timezone.utc).isoformat()
    })

@app.route("/health")
def health():
    return jsonify({
        "status": "healthy",
        "service": "DevOps-Flask-Service",
        "uptime": "operational"
    })

if __name__ == "__main__":
    port = int(os.getenv("PORT", 5000))
    app.run(host="0.0.0.0", port=port)
