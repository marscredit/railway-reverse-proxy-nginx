FROM nginx:latest

# Copy your Nginx configuration
COPY nginx.conf /etc/nginx/nginx.conf

# Copy your entrypoint script
COPY entrypoint.sh /usr/local/bin/

# Ensure the script is executable
RUN chmod +x /usr/local/bin/entrypoint.sh

# Expose the necessary ports
EXPOSE 80 443

# Set the entrypoint
ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]
