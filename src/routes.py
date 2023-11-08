from flask import jsonify, request
from src.models import Client
from src.extensions import db


def configure_routes(app):
    # Index
    @app.route("/")
    def index():
        return "This is the app index"

    # Add client and money
    @app.route("/api/clients/add", methods=['POST'])
    def add_client():
        data = request.json
        name = data.get('name')
        money = data.get('money')

        try:
            client = Client(
                name=name,
                money=money
            )

            db.session.add(client)
            db.session.commit()
            return "Client added with id={}".format(client.id), 201
        except Exception as e:
            return str(e)

    # Get all clients
    @app.route("/api/clients", methods=['GET'])
    def get_all():
        try:
            clients = Client.query.all()
            return jsonify([e.serialize() for e in clients]), 200
        except Exception as e:
            return str(e)

    # Get client by ID
    @app.route("/api/clients/<id_>", methods=['GET'])
    def get_by_id(id_):
        try:
            client = Client.query.filter_by(id=id_).first()
            return jsonify(client.serialize()), 200
        except Exception as e:
            return str(e)

    # Get client by Name
    @app.route("/api/clients/<name_>/name", methods=['GET'])
    def get_by_name(name_):
        try:
            client = Client.query.filter_by(name=name_).first()
            return jsonify(client.serialize()), 200
        except Exception as e:
            return str(e)
