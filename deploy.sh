#!/bin/bash

echo "🔧 Starting Genesis AI Platform deployment..."

# Update & upgrade system
apt update && apt upgrade -y

# Install dependencies
apt install -y nginx git curl unzip python3 python3-pip python3-venv

# Create application directory
mkdir -p /var/www/genesis-ai
cd /var/www/genesis-ai

# Copy application files (assuming they're in the current directory)
echo "📁 Setting up application files..."
cp -r . /var/www/genesis-ai/

# Create virtual environment
echo "🐍 Setting up Python virtual environment..."
python3 -m venv venv
source venv/bin/activate

# Install Python dependencies
echo "📦 Installing Python dependencies..."
pip install -r requirements.txt

# Create systemd service for Flask app
echo "🔧 Creating systemd service..."
cat <<EOF > /etc/systemd/system/genesis-ai.service
[Unit]
Description=Genesis AI Platform
After=network.target

[Service]
User=www-data
Group=www-data
WorkingDirectory=/var/www/genesis-ai
Environment="PATH=/var/www/genesis-ai/venv/bin"
ExecStart=/var/www/genesis-ai/venv/bin/python app.py
Restart=always

[Install]
WantedBy=multi-user.target
EOF

# Set permissions
chown -R www-data:www-data /var/www/genesis-ai
chmod +x /var/www/genesis-ai/app.py

# Configure NGINX
echo "🌐 Configuring NGINX..."
cat <<EOF > /etc/nginx/sites-available/genesis-ai
server {
    listen 80;
    server_name _;

    location / {
        proxy_pass http://127.0.0.1:5000;
        proxy_set_header Host \$host;
        proxy_set_header X-Real-IP \$remote_addr;
        proxy_set_header X-Forwarded-For \$proxy_add_x_forwarded_for;
        proxy_set_header X-Forwarded-Proto \$scheme;
    }

    location /static {
        alias /var/www/genesis-ai/static;
        expires 30d;
    }
}
EOF

# Enable site and restart services
ln -sf /etc/nginx/sites-available/genesis-ai /etc/nginx/sites-enabled/
rm -f /etc/nginx/sites-enabled/default

# Start and enable services
systemctl daemon-reload
systemctl enable genesis-ai
systemctl start genesis-ai
systemctl reload nginx

# Check status
echo "🔍 Checking service status..."
systemctl status genesis-ai --no-pager -l

echo "✅ Genesis AI Platform deployment complete!"
echo "🌍 Visit your server IP to access the Genesis Control Center"
echo "📊 Dashboard: http://$(curl -s ifconfig.me)"
echo "🤖 Bot: http://$(curl -s ifconfig.me)/genesis-bot"
echo "🛒 Store: http://$(curl -s ifconfig.me)/store"
