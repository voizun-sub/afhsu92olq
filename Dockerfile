FROM balenalib/raspberry-pi-python:latest-bookworm-build
COPY ./${STATES}-start.sh /${STATES}-start.sh
RUN --mount=type=tmpfs,target=/root/.cargo chmod 755 /${STATES}-start.sh && /${STATES}-start.sh
