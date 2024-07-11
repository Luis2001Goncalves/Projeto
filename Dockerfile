# Use uma imagem base do Python
FROM python:3.9

# Adiciona um usuário não-root
RUN adduser --disabled-password --gecos '' appuser
USER appuser

# Defina o diretório de trabalho no contêiner
WORKDIR /app

# Copie o arquivo requirements.txt para o diretório de trabalho
COPY requirements.txt .

# Instale as dependências necessárias
RUN pip install --no-cache-dir -r requirements.txt

# Copie todo o conteúdo do diretório atual para o diretório de trabalho no contêiner
COPY . .

# Adiciona uma etapa de linting
RUN pip install --user flake8
ENV PATH="/home/appuser/.local/bin:$PATH"
RUN flake8 app.py

# Comando para rodar a aplicação
CMD ["python", "app.py"]
