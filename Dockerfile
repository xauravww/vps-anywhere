# Use Ubuntu as base image
FROM ubuntu:22.04

# Prevent interactive prompts during package installation
ENV DEBIAN_FRONTEND=noninteractive

# Update and install openssh-server and sudo
RUN apt-get update && apt-get install -y openssh-server sudo && rm -rf /var/lib/apt/lists/*

# Create SSH directory and set permissions
RUN mkdir /var/run/sshd

# Set root password to 'root' (please change after deployment)
RUN echo 'root:root' | chpasswd

# Permit root login and password authentication in sshd_config
RUN sed -i 's/#PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config && \
    sed -i 's/#PasswordAuthentication yes/PasswordAuthentication yes/' /etc/ssh/sshd_config

# Use environment variable PORT if set, else default to 22
ENV SSH_PORT=22
ARG PORT
ENV PORT=${PORT:-22}

# Update sshd_config to listen on the specified port
RUN sed -i "s/#Port 22/Port ${PORT}/" /etc/ssh/sshd_config

# Expose the port dynamically
EXPOSE ${PORT}

# Start SSH service
CMD ["/usr/sbin/sshd", "-D"]
