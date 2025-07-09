#!/bin/bash

echo "🔧 Starting ArtificialLightCo platform setup..."

# Update & upgrade system
apt update && apt upgrade -y

# Install dependencies
apt install -y nginx git curl unzip

# Clone platform source (you'll swap this with your repo later)
mkdir -p /var/www/artificiallightco
cd /var/www/artificiallightco

echo "🌐 Setting up dummy index..."
cat <<EOF > index.html
<html>
  <head><title>ArtificialLightCo</title></head>
  <body>
    <h1>Welcome to ArtificialLightCo</h1>
    <p>The AI-powered platform is live.</p>
  </body>
</html>
EOF

# Configure NGINX
cat <<EOF > /etc/nginx/sites-available/artificiallightco
server {
    listen 80;
    server_name _;

    root /var/www/artificiallightco;
    index index.html;

    location / {
        try_files \$uri \$uri/ =404;
    }
}
EOF

ln -sf /etc/nginx/sites-available/artificiallightco /etc/nginx/sites-enabled/
rm -f /etc/nginx/sites-enabled/default
nginx -t && systemctl reload nginx

echo "✅ Deployment Complete. Visit your server IP to view the platform."
