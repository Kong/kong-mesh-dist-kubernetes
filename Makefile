
setup_minikube:
	sudo minikube delete 2>/dev/null
	sudo minikube start --vm-driver none
	sudo chown -R $$USER $$HOME/.minikube
	sudo chgrp -R $$USER $$HOME/.minikube

clean:
	kubectl delete -f https://raw.githubusercontent.com/Kong/kong-dist-kubernetes/kong-1.0/postgres.yaml
	kubectl delete -f https://raw.githubusercontent.com/Kong/kong-dist-kubernetes/kong-1.0/kong_migration_postgres.yaml
	kubectl delete -f https://raw.githubusercontent.com/Kong/kong-dist-kubernetes/kong-1.0/kong_postgres.yaml
	kubectl delete -f serviceb.yaml
	kubectl delete -f servicea.yaml

run: build-docker-images
	kubectl apply -f https://raw.githubusercontent.com/Kong/kong-dist-kubernetes/kong-1.0/postgres.yaml
	kubectl apply -f https://raw.githubusercontent.com/Kong/kong-dist-kubernetes/kong-1.0/kong_migration_postgres.yaml
	kubectl apply -f https://raw.githubusercontent.com/Kong/kong-dist-kubernetes/kong-1.0/kong_postgres.yaml
	kubectl apply -f serviceb.yaml
	kubectl apply -f servicea.yaml

build-docker-images:
	docker build -t kong:mesh -f Dockerfile.kong-mesh .
	docker build -t kong:config -f Dockerfile.kong-config .

