FROM mcr.microsoft.com/dotnet/sdk:6.0

RUN dotnet tool install --global ilspycmd && \
  ln -s /root/.dotnet/tools/ilspycmd /usr/local/bin/ilspycmd && \
  mkdir -p /data/in /data/out

WORKDIR /
ENTRYPOINT [ "/usr/local/bin/ilspycmd" ]
CMD [ "--help" ]
