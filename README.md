# VPS Anywhere: In-Browser Terminal with Docker & Render

This project provides a Dockerfile to deploy a web-based terminal (using [ttyd](https://github.com/tsl0922/ttyd)) to platforms like Render.com. When deployed, you can access a full-featured bash shell directly from your browser.

## Features

- Lightweight Alpine Linux base
- [ttyd](https://github.com/tsl0922/ttyd): share terminal over the web
- Bash shell in-browser
- Easy deployment to Render or any container host

## Usage

### Build the Docker image

```bash
docker build -t vps-anywhere .
```

### Run the container locally

```bash
docker run -d -p 7681:7681 --name my-vps vps-anywhere
```

This maps port 7681 on your host to port 7681 in the container.

### Access the Terminal

Open your browser and go to:

```
http://localhost:7681
```

You will see a bash terminal running in your browser.

## Deploying to Render.com or Similar Hosting Providers

1. Push your code (with this Dockerfile) to a GitHub repository.
2. On Render.com, create a new **Web Service** and connect your repository.
3. Set the port to `7681` (Render will ask for this during setup).
4. Deploy the service.
5. Open the Render-provided URL in your browser to access your terminal.

## Security Note

- By default, anyone with the URL can access the terminal. For production, add authentication or restrict access.
- Do **not** use this for sensitive workloads unless you secure it.

## Customization
- You can change the shell (e.g., to `sh` or `zsh`) by editing the last line of the Dockerfile.
- To add authentication, consider using a reverse proxy or ttyd's built-in options.

## Troubleshooting
- If you can't access the terminal, ensure the service is running and the correct port is exposed.
- Check container logs for errors:

```bash
docker logs my-vps
```
