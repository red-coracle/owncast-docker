# owncast-docker

Dockerized version of [Owncast](https://github.com/owncast/owncast)

Features:
- Built daily from `develop` branch
- Images for both x86/ARM
- Includes Intel drivers for VA-API hardware acceleration

### Usage
Run on Docker:
```sh
docker run -v $(pwd)/data:/app/data -d ghcr.io/red-coracle/owncast:latest
```

Or see [docker-compose](https://github.com/red-coracle/owncast-docker/blob/master/docker-compose.yml) example.
