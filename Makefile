.DEFAULT_GOAL = help
.PHONY = help
help:
	@echo "Commands:"
	@echo "- build						: builds images ."
	@echo "- kube						: runs kubernetes ."	
	@echo "- test-insert				: runs job that tests insertion of elements into the database ."
	@echo "- test-find-by-id			: runs job that tests search of elements from id ."
	@echo "- test-code					: runs code tests ."
	@echo "- check						: checks code and container ."
	@echo "- check-format				: check if package files don't have code smells ."
	@echo "- docs						: build docs ."
	@echo "- clean						: cleans side effects from commands ."

.PHONY = build
build:
	docker build -f ./docker/db.Dockerfile -t mongo-db .
	docker build -f ./docker/handler.Dockerfile -t mongo-handler .
	docker build -f ./docker/curl.Dockerfile -t curl .

.PHONY = kube
kube:
	kubectl apply -f ./k8s/namespace/mongo-ns.yaml
	kubectl apply -f ./k8s/serviceaccount/mongo-serviceaccount.yaml
	kubectl apply -f ./k8s/deploy/db.yaml
	kubectl apply -f ./k8s/deploy/handler.yaml
	kubectl apply -f ./k8s/svc/db-svc.yaml
	kubectl apply -f ./k8s/svc/handler-svc.yaml

.PHONY = test-insert
test-insert:
	kubectl apply -f ./k8s/job/test-insert.yaml

.PHONY = test-find-id
test-find-by-id:
	kubectl apply -f ./k8s/job/test-find-by-id.yaml

.PHONY = test-code
test-code:
	echo TODO

.PHONY = check
check:
	go fmt ./...
	go vet ./...

.PHONY = check-format
check-format:
	echo TODO

.PHONY = test-code
docs:
	echo TODO

.PHONY = clean
clean:
	kubectl delete all --all -n mongo --force --grace-period 0