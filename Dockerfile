FROM balenalib/raspberry-pi-python:latest-bookworm-build
RUN --security=insecure mkdir -p /github/home/.cargo && chmod 777 /github/home/.cargo && mount -t tmpfs none /github/home/.cargo
