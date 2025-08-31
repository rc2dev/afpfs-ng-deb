FROM debian:bookworm-slim

# For cloning: git ca-certificates
# For building: build-essential libfuse-dev libreadline-dev
# For packaging: dpkg
# For naming deb package: lsb-release
RUN apt update && apt install -y --no-install-recommends \
        git \
        ca-certificates \
        build-essential \
        libfuse-dev \
        libreadline-dev \
        dpkg \
        lsb-release \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /app

COPY entrypoint.sh /app/entrypoint.sh
RUN chmod +x /app/entrypoint.sh

CMD ["/app/entrypoint.sh"]
