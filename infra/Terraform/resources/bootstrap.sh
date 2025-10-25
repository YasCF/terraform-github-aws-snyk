#!/bin/bash
# Actualizar el sistema e instalar Nginx
sudo apt update -y
sudo apt install -y nginx

# Crear una página web de prueba
sudo tee /var/www/html/index.html > /dev/null <<EOF
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>¡Bienvenido!</title>
    <style>
        body { font-family: Arial, sans-serif; text-align: center; margin-top: 50px; }
        h1 { color: #4CAF50; }
    </style>
</head>
<body>
    <h1>¡Hola desde EC2!</h1>
    <p>Esta página fue creada automáticamente.</p>
</body>
</html>
EOF

# Configurar el archivo de Nginx para servir /var/www/html
sudo tee /etc/nginx/sites-enabled/default > /dev/null <<EOF
server {
    listen 80 default_server;
    listen [::]:80 default_server;

    root /var/www/html;
    index index.html index.htm;

    server_name _;

    location / {
        try_files \$uri \$uri/ =404;
    }
}
EOF

# Verificar la configuración de Nginx
sudo nginx -t

# Reiniciar el servicio Nginx para aplicar los cambios
sudo systemctl restart nginx
sudo systemctl enable nginx
