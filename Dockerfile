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
    xfce4 xfce4-goodies xorg dbus-x11 x11-xserver-utils \
    x11vnc \
    novnc websockify \
    nginx \
    && rm -rf /var/lib/apt/lists/*

# Set root password (change for security!)
RUN echo "root:root" | chpasswd

# Configure SSH
RUN mkdir /var/run/sshd
RUN sed -i 's/#PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config && \
    sed -i 's/#PasswordAuthentication yes/PasswordAuthentication yes/' /etc/ssh/sshd_config

# Set up a default password for VNC
RUN x11vnc -storepasswd 1234 /etc/x11vnc.pass

# Supervisor and nginx config
RUN mkdir -p /etc/supervisor.d
COPY supervisord-ttyd-sshd.ini /etc/supervisor.d/
COPY supervisord.conf /etc/supervisord.conf
COPY nginx.conf /etc/nginx/nginx.conf

# Expose HTTP, ttyd, SSH, and noVNC ports
EXPOSE 80 7681 22 6080

# Start supervisor to run all services
CMD ["supervisord", "-c", "/etc/supervisord.conf"]
