FROM balenalib/raspberry-pi:latest-bookworm-build
COPY ./start.sh /start.sh
RUN --mount=type=tmpfs,target=/root/.cargo chmod 755 /start.sh && /start.sh
