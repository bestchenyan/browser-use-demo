# browser-use Docker Container

This repository provides a Docker setup for running [browser-use](https://github.com/browser-use/browser-use) inside a container. The container provides VNC access for debugging.

## Prerequisites

- [Docker](https://docs.docker.com/get-docker/)
- [Docker Compose](https://docs.docker.com/compose/install/)

## Using

Create docker-compose.yml file:

```yaml
services:
  browser-use:
    image: vovan/browser-use
    container_name: browser-use
    environment:
      - DEEPSEEK_API_KEY=xxxxxxxx
    ports:
      - "5900:5900"
```

Run the container:

```sh
docker compose up
```

Access the container shell to manually run scripts inside the container:

```sh
docker compose exec browser-use bash
```

Run `browser-use` inside the container:

```sh
python gpt-demo.py
```

## Connect via VNC

Use any VNC client and connect to:

```
localhost:5900
```

Password: `secret`

## Stopping the Container

To stop the running container:

```sh
docker compose down
```

## License

This project is open-source and licensed under the MIT License.
