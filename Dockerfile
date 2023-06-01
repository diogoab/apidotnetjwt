# Imagem base
FROM mcr.microsoft.com/dotnet/sdk:7.0 AS build-env

# Diretório de trabalho
WORKDIR /app

# Copiar os arquivos do projeto
COPY . ./

# Restaurar as dependências
RUN dotnet restore

# Compilar o aplicativo
RUN dotnet build -c Release --no-restore

# Publicar o aplicativo
RUN dotnet publish -c Release -o out --no-restore

# Imagem final
FROM mcr.microsoft.com/dotnet/aspnet:7.0

# Diretório de trabalho
WORKDIR /app

# Copiar os arquivos publicados do estágio anterior
COPY --from=build-env /app/out .

# Comando de execução do aplicativo
ENTRYPOINT ["dotnet", "ApiWithAuth.dll"]
