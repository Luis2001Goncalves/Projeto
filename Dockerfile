# Use a imagem base do Python
FROM python:3.9

# Defina o diretório de trabalho
WORKDIR /app

# Copie o arquivo requirements.txt e instale as dependências
COPY requirements.txt requirements.txt
RUN pip install -r requirements.txt

# Copie o código da aplicação
COPY . .

# Defina o comando para rodar a aplicação
CMD ["python", "app.py"]