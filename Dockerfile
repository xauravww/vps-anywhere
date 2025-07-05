FROM ubuntu:22.04

# Prevent interactive prompts during package installation
ENV DEBIAN_FRONTEND=noninteractive

# Update and install required packages
RUN apt-get update && apt-get install -y \
    ttyd \
    openssh-server \
    sudo \
    bash \
    tmate \
    supervisor \
    && rm -rf /var/lib/apt/lists/*

# Set root password (change for security!)
RUN echo "root:root" | chpasswd

# Configure SSH
RUN mkdir /var/run/sshd
RUN sed -i 's/#PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config && \
    sed -i 's/#PasswordAuthentication yes/PasswordAuthentication yes/' /etc/ssh/sshd_config

# Supervisor config
RUN mkdir -p /etc/supervisor.d
COPY supervisord-ttyd-sshd.ini /etc/supervisor.d/
COPY supervisord.conf /etc/supervisord.conf

# Expose ttyd and SSH ports
EXPOSE 7681 22

# Start supervisor to run all services
CMD ["supervisord", "-c", "/etc/supervisord.conf"]
