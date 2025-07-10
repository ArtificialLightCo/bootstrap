from flask import Flask, render_template, request, jsonify, redirect, url_for, send_file
import os
import json
from datetime import datetime
import random

app = Flask(__name__)
app.secret_key = 'genesis_ai_secret_key_2024'

# Sample data for the platform
products = [
    {
        'id': 1,
        'name': '🧠 Mental Clarity Toolkit',
        'description': 'Unlock focused flow states with science-backed tools. Includes multilingual affirmations, planners, & audio triggers.',
        'price': 29.99,
        'category': 'productivity',
        'download_url': '/downloads/mental_clarity_toolkit.zip'
    },
    {
        'id': 2,
        'name': '🔥 Fitness Habit Hacker Bundle',
        'description': 'Train smarter, not harder — with AI-personalized fitness routines and habit tracking.',
        'price': 49.99,
        'category': 'fitness',
        'download_url': '/downloads/fitness_bundle.zip'
    },
    {
        'id': 3,
        'name': '⚡ AI Productivity Suite',
        'description': 'Dominate your day with psychology-based routines and AI-powered task management.',
        'price': 79.99,
        'category': 'productivity',
        'download_url': '/downloads/productivity_suite.zip'
    }
]

analytics_data = {
    'total_sales': 15420,
    'monthly_revenue': 3240,
    'active_users': 892,
    'conversion_rate': 3.2
}

@app.route('/')
def genesis_control():
    """Main Genesis Control Center dashboard"""
    return render_template('genesis_control.html', analytics=analytics_data)

@app.route('/store')
def store():
    """Psychological storefront"""
    return render_template('psych_store.html', products=products)

@app.route('/api/products')
def api_products():
    """API endpoint for products"""
    return jsonify(products)

@app.route('/api/analytics')
def api_analytics():
    """API endpoint for analytics"""
    return jsonify(analytics_data)

@app.route('/downloads/<filename>')
def download_file(filename):
    """Handle file downloads"""
    # In a real app, you'd serve actual files
    # For now, we'll create a simple response
    if filename == 'mental_clarity_toolkit.zip':
        return "Mental Clarity Toolkit - Download Complete!", 200
    elif filename == 'fitness_bundle.zip':
        return "Fitness Habit Hacker Bundle - Download Complete!", 200
    elif filename == 'productivity_suite.zip':
        return "AI Productivity Suite - Download Complete!", 200
    else:
        return "File not found", 404

@app.route('/genesis-bot')
def genesis_bot():
    """Genesis Prime Bot interface"""
    return render_template('genesis_bot.html')

@app.route('/swarm-traffic')
def swarm_traffic():
    """Genesis Swarm Traffic monitoring"""
    return render_template('swarm_traffic.html')

@app.route('/vault')
def vault():
    """Vault access page"""
    return render_template('vault.html')

@app.route('/api/bot/chat', methods=['POST'])
def bot_chat():
    """Handle bot chat requests"""
    data = request.get_json()
    user_message = data.get('message', '')
    
    # Simple bot responses
    responses = [
        "I'm analyzing your request through the Genesis AI network...",
        "Processing your query with advanced neural pathways...",
        "The Genesis swarm is coordinating your response...",
        "AI optimization complete. Here's your solution...",
        "Neural network consensus reached. Proceeding with execution..."
    ]
    
    return jsonify({
        'response': random.choice(responses),
        'timestamp': datetime.now().isoformat()
    })

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5000, debug=True)