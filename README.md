# VPS Docker Container

This Dockerfile creates a container that can be deployed to hosting providers (e.g., render.com) and used as a VPS with root SSH access.

## Features

- Ubuntu 22.04 base image
- OpenSSH server installed and configured
- Root login enabled with password authentication
- Default root password: `root` (please change after deployment)
- SSH port 22 exposed

## Usage

### Build the Docker image

```bash
docker build -t vps-container .
```

### Run the container

```bash
docker run -d -p 2222:22 --name my-vps vps-container
```

This maps port 2222 on your host to port 22 in the container.

### Connect via SSH

```bash
ssh root@localhost -p 2222
```

Password: `root`

## Important Notes

- Change the root password immediately after connecting for security.
- This container provides root access via SSH, so use it responsibly.
- When deploying to hosting providers like render.com, ensure the SSH port is exposed and accessible.

## Troubleshooting

- If you cannot connect, verify the container is running and the SSH service is active.
- Check container logs for any errors:

```bash
docker logs my-vps
