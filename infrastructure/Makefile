# Vars
FLASK_APP=main.py
FLASK_ENV=development
DATABASE_URI=sqlite:///app.db

# Setup the database
deployment_all:
	kubectl apply -f db-deployment.yml
	kubectl apply -f db-service.yml
	kubectl apply -f web-deployment.yml
	kubectl apply -f web-service.yml
	kubectl apply -f job-migrate.yml

delete_all:
	kubectl delete -n default deployment web
	kubectl delete -n default service web
	kubectl delete -n default deployment db
	kubectl delete -n default service db

.PHONY: deployment_all delete_all test migrate_dev