#!/usr/bin/env python3
"""
Genesis AI Platform - Development Server
Simple startup script for local development
"""

import os
import sys
from app import app

if __name__ == '__main__':
    print("🌍 Starting Genesis AI Platform...")
    print("📊 Dashboard: http://localhost:5000")
    print("🤖 Bot: http://localhost:5000/genesis-bot")
    print("🛒 Store: http://localhost:5000/store")
    print("🚀 Swarm: http://localhost:5000/swarm-traffic")
    print("🔐 Vault: http://localhost:5000/vault")
    print("\nPress Ctrl+C to stop the server\n")
    
    # Run the Flask development server
    app.run(
        host='0.0.0.0',
        port=5000,
        debug=True,
        use_reloader=True
    )