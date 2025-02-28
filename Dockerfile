FROM mcr.microsoft.com/dotnet/sdk:9.0.200 AS build-env

WORKDIR /src

COPY ./src/Demo.Api/ .
RUN dotnet publish Demo.Api.csproj \
    -c Release \
    --self-contained true \
    -o /out



FROM mcr.microsoft.com/dotnet/runtime:9.0.2

WORKDIR /app
COPY --from=build-env /out .

USER app

ENTRYPOINT ["dotnet", "Demo.Api.dll"]
