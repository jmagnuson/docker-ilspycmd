FROM mcr.microsoft.com/dotnet/sdk:6.0-alpine

RUN dotnet tool install --global ilspycmd && \
  ln -s /root/.dotnet/tools/ilspycmd /usr/local/bin/ilspycmd && \
  mkdir -p /data/in /data/out

VOLUME [ "/data/in" ]
VOLUME [ "/data/out" ]

ENTRYPOINT [ "/usr/local/bin/ilspycmd" ]
CMD [ "--help" ]
