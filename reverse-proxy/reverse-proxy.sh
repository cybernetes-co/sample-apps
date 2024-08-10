#!/opt/homebrew/Cellar/bash/5.2.32/bin/bash

# Define the mapping of hostnames to backend servers
declare -A HOSTS
HOSTS=(
	["myapp.local"]="http://localhost:7000"
	["anotherapp.local"]="http://localhost:80"
)

# Path to the Nginx configuration file
NGINX_CONF="/opt/homebrew/etc/nginx/nginx.conf"

cp $NGINX_CONF ${NGINX_CONF}.bak

# Start building the new Nginx configuration
cat <<EOF >$NGINX_CONF
worker_processes  1;

events {
    worker_connections  1024;
}

http {
EOF

for HOSTNAME in "${!HOSTS[@]}"; do
	BACKEND=${HOSTS[$HOSTNAME]}
	cat <<EOF >>$NGINX_CONF
    server {
        listen 8888;
        server_name $HOSTNAME;

        location / {
            proxy_pass $BACKEND;
            proxy_set_header Host \$host;
            proxy_set_header X-Real-IP \$remote_addr;
            proxy_set_header X-Forwarded-For \$proxy_add_x_forwarded_for;
            proxy_set_header X-Forwarded-Proto \$scheme;
        }
    }
EOF
done

# /opt/homebrew/opt/nginx/bin/nginx -s reload
echo "Nginx configuration updated and reloaded."
