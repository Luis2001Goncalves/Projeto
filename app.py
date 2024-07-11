from flask import Flask
import logging

app = Flask(__name__)

logging.basicConfig(level=logging.INFO)

@app.route('/')
def hello_world():
    app.logger.info('Serving Hello World!')
    return 'Olá Mundo!'

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5000)
