# Face Client Service API

This project is a facial recognition client service API that allows users to know the amount of money they have in their virtual account. The API is built with Flask and deployed on Kubernetes, featuring observability and a CI/CD pipeline.

## Getting Started

These instructions will get you a copy of the project up and running on your local machine for development and testing purposes.

### Prerequisites

You need to have Docker and Docker Compose installed to build and run the infrastructure locally.

### Installation

To set up the development environment, follow these steps:

1. Clone the repository:

git clone https://github.com/Murzbul/face-client-api

2. Copy the `.env.example` file to `.env` and replace the values with your specific configurations:

cp .env.example .env

3. Build and run the containers with Docker Compose:

docker compose up --build -d

## Database Migrations

This application uses Flask-Migrate to handle database migrations. To perform the initial setup and apply migrations, follow these steps:

1. Make sure you have all the requirements installed from `requirements.txt`.
2. Ensure your environment variables are set correctly, including `DATABASE_URL` which should point to your development or production database.
3. Run the following commands to set up your database:

```sh
   make init_db
```

NOTE: 
## Running the Tests

To run the automated tests for this system, use the following command:

python -m unittest discover


## Deployment

Deployment is performed via a CI/CD pipeline that builds the Docker image and deploys it to a Kubernetes cluster.

## Built With

* [Flask](http://flask.pocoo.org/) - The web framework used
* [SQLAlchemy](https://www.sqlalchemy.org/) - ORM and database handler
* [PostgreSQL](https://www.postgresql.org/) - The database used
* [Docker](https://www.docker.com/) - Containerization and orchestration
* [Kubernetes](https://kubernetes.io/) - Automation of container deployment, scaling, and operations

## Contributing

Please read [CONTRIBUTING.md](https://github.com/Murzbul/face-client-api/CONTRIBUTING.md) for details on our code of conduct, and the process for submitting pull requests to us.

## Versioning

We use [SemVer](http://semver.org/) for versioning. For the versions available, see the [tags on this repository](https://github.com/Murzbul/face-client-api/tags).

## Authors

* **Nathan M. Russo** - *Initial Work* - [Murzbul](https://github.com/Murzbul)

## License

This project is licensed under the MIT License - see the [LICENSE.md](LICENSE.md) file for details.
