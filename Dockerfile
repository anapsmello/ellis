# Use uma imagem oficial do Python como imagem base.
# python:3.13.4-alpine3.22 é uma boa escolha por ser leve.
FROM python:3.13.4-alpine3.22

# Define o diretório de trabalho dentro do contêiner.
WORKDIR /app

# Copia o arquivo de dependências primeiro para aproveitar o cache do Docker.
# Se o requirements.txt não mudar, esta camada não será reconstruída.
COPY requirements.txt .

# Instala as dependências.
# --no-cache-dir desativa o cache do pip para manter a imagem menor.
RUN pip install --no-cache-dir -r requirements.txt

# Copia o restante do código da aplicação para o diretório de trabalho.
COPY . .

# Expõe a porta 8000 para que a aplicação possa ser acessada de fora do contêiner.
EXPOSE 8000

# Comando para executar a aplicação quando o contêiner for iniciado.
# --host 0.0.0.0 é necessário para que a aplicação seja acessível externamente.
CMD ["uvicorn", "app:app", "--host", "0.0.0.0", "--port", "8000", "--reload"]