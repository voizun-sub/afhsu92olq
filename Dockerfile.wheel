FROM balenalib/raspberry-pi-python:latest-bookworm-build
COPY ./wheel-start.sh /wheel-start.sh
RUN --mount=type=tmpfs,target=/root/.cargo chmod 755 /wheel-start.sh && /wheel-start.sh
