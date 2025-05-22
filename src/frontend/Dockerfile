FROM nginx:alpine

# Copy the static files to /var/www/html (instead of default /usr/share/nginx/html)
COPY src/ /var/www/html/

# Copy nginx template
COPY nginx.conf.template /etc/nginx/templates/default.conf.template

# Expose port
EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]

# The official nginx Docker image automatically:
#     Looks for .template files in /etc/nginx/templates/
#     Processes them with envsubst
#     Places the processed files in /etc/nginx/conf.d/