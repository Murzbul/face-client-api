# Vars
FLASK_APP=main.py
FLASK_ENV=development
DATABASE_URI=sqlite:///app.db

# Setup the database
init_db:
	FLASK_APP=$(FLASK_APP) FLASK_ENV=$(FLASK_ENV) flask db init
	FLASK_APP=$(FLASK_APP) FLASK_ENV=$(FLASK_ENV) flask db migrate -m "Initial migration."
	FLASK_APP=$(FLASK_APP) FLASK_ENV=$(FLASK_ENV) flask db upgrade

# Run tests with migration
ci_test_with_migration:
	FLASK_APP=main_test.py FLASK_ENV=test APP_SETTINGS=config.TestingConfig DATABASE_URI=$(DATABASE_URI) flask db upgrade
	FLASK_APP=main_test.py FLASK_ENV=test APP_SETTINGS=config.TestingConfig DATABASE_URI=$(DATABASE_URI) python -m unittest discover -s tests
	rm -rf app.db

# Run tests
test:
	FLASK_APP=main_test.py FLASK_ENV=test APP_SETTINGS=config.TestingConfig DATABASE_URI=$(DATABASE_URI) flask db upgrade
	FLASK_APP=main_test.py FLASK_ENV=test APP_SETTINGS=config.TestingConfig DATABASE_URI=$(DATABASE_URI) python -m unittest discover -s tests

# Migrate for development environment
migrate_dev:
	FLASK_APP=$(FLASK_APP) FLASK_ENV=$(FLASK_ENV) flask db migrate -m "Development migration."
	FLASK_APP=$(FLASK_APP) FLASK_ENV=$(FLASK_ENV) flask db upgrade

.PHONY: init_db ci_test_with_migration test migrate_dev