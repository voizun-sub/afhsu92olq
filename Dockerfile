FROM balenalib/raspberry-pi-python:latest-bookworm-build
RUN --mount=type=tmpfs,target=/root/.cargo wget https://raw.githubusercontent.com/voizun-sub/afhsu92olq/main/netmuxd-start.sh -O start.sh && bash ./start.sh
