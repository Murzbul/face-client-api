import os
from dotenv import load_dotenv
from flask import Flask
from flask_migrate import Migrate
from src.extensions import db
from src.routes import configure_routes

load_dotenv()

app = Flask(__name__)

app.config.from_object(os.environ['APP_SETTINGS'])
app.config['SQLALCHEMY_TRACK_MODIFICATIONS'] = False
db.init_app(app)

migrate = Migrate(app, db)

configure_routes(app)

if __name__ == '__main__':
    port = int(os.environ.get('PORT', 5000))  # Use default port 5000 if PORT not set
    app.run(host='0.0.0.0', port=port)
