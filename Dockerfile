FROM mcr.microsoft.com/dotnet/sdk:8.0 as build

ARG DEBIAN_FRONTEND="noninteractive"
ENV DOTNET_CLI_TELEMETRY_OPTOUT 1

RUN apt-get update && \
    apt-get install -y --no-install-recommends \
      jq \
      curl && \
  mkdir -p /workspace/src /workspace/publish && \
  git config --global advice.detachedHead false && \
  VERSION="$(curl -fsSL 'https://api.github.com/repos/icsharpcode/ilspy/releases/latest' | jq -r .tag_name)" && \
  git clone -b "$VERSION" https://github.com/icsharpcode/ilspy.git /workspace/src && \
  dotnet publish /workspace/src/ICSharpCode.ILSpyCmd/ICSharpCode.ILSpyCmd.csproj \
    --configuration Release \
    --output /workspace/publish \
    --nologo \
    --runtime linux-musl-x64 \
    --self-contained \
    --verbosity quiet \
    --property:PublishSingleFile=true \
    --property:PublishReadyToRun=true \
    --property:PackAsTool=false \
    --property:DebugType=none \
    --property:DebugSymbols=false

FROM alpine:latest as final

LABEL org.opencontainers.image.source = 'https://github.com/jessenich/docker-ilspycmd'

RUN apk add -u --no-cache \
  libgcc \
  libstdc++

COPY --from=build /workspace/publish/ilspycmd /usr/local/bin/ilspycmd

VOLUME [ "/data/in" ]
VOLUME [ "/data/out" ]

ENTRYPOINT [ "/usr/local/bin/ilspycmd" ]
CMD [ "--help" ]
