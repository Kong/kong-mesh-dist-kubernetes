
setup_minikube:
	-sudo minikube delete 2>/dev/null
	sudo minikube start --vm-driver none
	sudo minikube addons enable registry
	sudo chown -R $$USER $$HOME/.minikube
	sudo chgrp -R $$USER $$HOME/.minikube
	sudo chown -R $$USER $$HOME/.kube
	sudo chgrp -R $$USER $$HOME/.kube
	sudo minikube update-context
	until kubectl get nodes 2>&1 | sed -n 2p | grep -q Ready; do sleep 1 && kubectl get nodes; done
	kubectl create -f kube-registry.yaml

clean:
	kubectl delete -f https://raw.githubusercontent.com/Kong/kong-dist-kubernetes/master/minikube/postgres.yaml
	kubectl delete -f https://raw.githubusercontent.com/Kong/kong-dist-kubernetes/master/minikube/kong_migration_postgres.yaml
	kubectl delete -f https://raw.githubusercontent.com/Kong/kong-dist-kubernetes/master/minikube/kong_postgres.yaml
	kubectl delete -f serviceb.yaml
	kubectl delete -f servicea.yaml

run:
	kubectl apply -f https://raw.githubusercontent.com/Kong/kong-dist-kubernetes/master/minikube/postgres.yaml
	kubectl apply -f https://raw.githubusercontent.com/Kong/kong-dist-kubernetes/master/minikube/kong_migration_postgres.yaml
	kubectl apply -f https://raw.githubusercontent.com/Kong/kong-dist-kubernetes/master/minikube/kong_postgres.yaml

run_services:
	kubectl apply -f serviceb.yaml
	kubectl apply -f servicea.yaml

