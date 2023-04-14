FROM mcr.microsoft.com/dotnet/sdk:6.0-alpine

LABEL org.opencontainers.image.source https://github.com/jessenich/docker-ilspycmd

RUN dotnet tool install --global ilspycmd && \
  ln -s /root/.dotnet/tools/ilspycmd /usr/local/bin/ilspycmd && \
  mkdir -p /data/in /data/out

VOLUME [ "/data/in" ]
VOLUME [ "/data/out" ]

ENTRYPOINT [ "/usr/local/bin/ilspycmd" ]
CMD [ "--help" ]
