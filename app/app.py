#!/usr/bin/env python3
"""DevOps Student Application — Zhebegenov Ersultan.

Prints student information on start and serves it over HTTP,
so the container keeps running (docker ps / logs / exec / stop / start).
All values come from environment variables.
"""
import os
import signal
import socket
import sys
from datetime import datetime
from http.server import BaseHTTPRequestHandler, HTTPServer

PORT = int(os.getenv("APP_PORT", "8000"))


def student_info() -> str:
    line = "=" * 32
    return "\n".join([
        line,
        "DevOps Student Application",
        line,
        f"Name: {os.getenv('STUDENT_NAME', 'Ersultan')}",
        f"Surname: {os.getenv('STUDENT_SURNAME', 'Zhebegenov')}",
        f"Group: {os.getenv('STUDENT_GROUP', 'IT2-2309')}",
        f"Student ID: {os.getenv('STUDENT_ID', '37138')}",
        f"Container: {socket.gethostname()}",
        line,
        "Application is running successfully!",
    ])


class Handler(BaseHTTPRequestHandler):
    def do_GET(self):
        body = (student_info() + "\n").encode()
        self.send_response(200)
        self.send_header("Content-Type", "text/plain; charset=utf-8")
        self.send_header("Content-Length", str(len(body)))
        self.end_headers()
        self.wfile.write(body)

    def log_message(self, fmt, *args):
        print(f"[{datetime.now():%Y-%m-%d %H:%M:%S}] INFO Request: {fmt % args}", flush=True)


def stop(signum, frame):
    print("INFO Application stopped", flush=True)
    sys.exit(0)


if __name__ == "__main__":
    signal.signal(signal.SIGTERM, stop)   # so `docker stop` finishes instantly
    print(student_info(), flush=True)
    print(f"INFO Listening on port {PORT}", flush=True)
    try:
        HTTPServer(("0.0.0.0", PORT), Handler).serve_forever()
    except KeyboardInterrupt:
        stop(None, None)
