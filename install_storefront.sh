#!/bin/bash

cd /var/www/artificiallightco/store

cat <<EOF > index.html
<!DOCTYPE html>
<html>
<head>
  <title>ArtificialLightCo Store</title>
  <style>
    body { font-family: Arial; background: #f9f9f9; padding: 2rem; }
    h1 { font-size: 2rem; margin-bottom: 1rem; }
    .product {
      background: white;
      padding: 1rem;
      border: 1px solid #ddd;
      border-radius: 8px;
      margin-bottom: 1rem;
    }
    .product h2 { margin: 0; }
    .product p { margin: 0.5rem 0; }
    a { color: #3366cc; text-decoration: underline; }
  </style>
</head>
<body>
  <h1>🛒 ArtificialLightCo Digital Store</h1>

  <div class="product">
    <h2>🧠 AI Productivity Toolkit</h2>
    <p>Dominate your day with psychology-based routines.</p>
    <a href="#">Download Now</a>
  </div>

  <div class="product">
    <h2>🔥 Fitness Habit Hacker Bundle</h2>
    <p>Train smarter, not harder — with AI-personalized fitness.</p>
    <a href="#">Get Access</a>
  </div>

</body>
</html>
EOF

systemctl reload nginx
