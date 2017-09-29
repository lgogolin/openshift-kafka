NAMESPACE ?= kafka

.PHONY: configure
configure:
	./bin/configure.sh

.PHONY: install
install:
	./bin/install.sh

.PHONY: deploy-producer
start-producer:
	helm install --name producer --namespace $(NAMESPACE) -f ./producer/values.yaml ./charts/nodejs

.PHONY: start-consumer
start-consumer:
	oc -n $(NAMESPACE) exec -ti $(NAMESPACE)-kafka-cli -- ./bin/kafka-console-consumer.sh --bootstrap-server $(NAMESPACE)-kafka:9092 --topic test1 --from-beginning
