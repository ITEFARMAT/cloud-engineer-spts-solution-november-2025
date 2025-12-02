
Short guide — how to build and run the backend (FastAPI)

- Build the image (from the repository root):

```bash
docker build -f docker/backend.dockerfile -t sample-api-app:latest .
```

- Alternatively, if you run the build from the `docker/` directory:

```bash
cd docker
docker build -f backend.dockerfile -t sample-api-app:latest ..
```

- Run the image locally (quick test):

```bash
docker run --rm -p 8000:8000 sample-api-app:latest
```

- Start in development mode (different port):

```bash
docker run --rm -p 8080:8080 -e PORT=8080 -e DEVELOPMENT=true sample-api-app:latest
```

- Docker Compose (example configuration) — ensure `build.context` points to the repository root:

```yaml
services:
  backend:
    build:
      context: .
      dockerfile: docker/backend.dockerfile
    ports:
      - "8000:8000"
    environment:
      - PORT=8000
      - DEVELOPMENT=false
```

 Docker Compose — build and run

 - Build images defined in `docker-compose.yml` (default file in current directory):

 ```bash
 docker compose build
 ```

 - Build a specific service (e.g. `backend`):

 ```bash
 docker compose build backend
 ```

 - Build using a custom compose file (e.g. `sandbox.yaml` in repo root):

 ```bash
 docker compose -f sandbox.yaml build
 ```

 - Start services (build + up) and follow logs:

 ```bash
 docker compose up --build
 ```

 - Start with a custom compose file:

 ```bash
 docker compose -f sandbox.yaml up --build
 ```

 - Stop and remove containers created by compose:

 ```bash
 docker compose down --remove-orphans
 ```
