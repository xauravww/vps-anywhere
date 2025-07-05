FROM alpine:latest

# Install ttyd, bash, openssh, and supervisor
RUN apk add --no-cache ttyd bash openssh supervisor

# Set root password (change for security!)
RUN echo "root:root" | chpasswd

# Create supervisor config
RUN mkdir -p /etc/supervisor.d
COPY supervisord-ttyd-sshd.ini /etc/supervisor.d/
COPY supervisord.conf /etc/supervisord.conf

# Expose ttyd and SSH ports
EXPOSE 7681 22

# Start supervisor to run both ttyd and sshd
CMD ["supervisord", "-c", "/etc/supervisord.conf"]
