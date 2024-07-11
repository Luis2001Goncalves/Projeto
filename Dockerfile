# Dockerfile
FROM python:3.9

# Adiciona um usuário não root
RUN adduser --disabled-password --gecos '' appuser

# Define o diretório de trabalho
WORKDIR /app

# Copia o arquivo de requisitos e instala as dependências
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Copia o código da aplicação para o contêiner
COPY . .

# Adiciona uma etapa de linting
RUN pip install --user flake8
RUN flake8 app.py

# Comando para rodar a aplicação
CMD ["python", "app.py"]
