import os
from flask import Flask
from flask_migrate import Migrate
from src.extensions import db
from src.routes import configure_routes


app = Flask(__name__)

app.config.from_object(os.environ['APP_SETTINGS'])
app.config['SQLALCHEMY_TRACK_MODIFICATIONS'] = False
db.init_app(app)

migrate = Migrate(app, db)

configure_routes(app)

if __name__ == '__main__':
    app.run()
