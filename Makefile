# Короткие команды для учебного стенда. Запускать из корня репозитория.
SHELL := /bin/bash
PROFILES ?=
COMPOSE := docker compose $(foreach p,$(PROFILES),--profile $(p))

.PHONY: up down ps logs reset cluster-up cluster-down cluster-ps cluster-reset secure-up secure-down

up:        ## запустить стенд и дождаться готовности
	@$(COMPOSE) up -d --wait --wait-timeout 180
	@echo "Стенд запущен. Kafbat UI: порт 18080 (вкладка PORTS)."

down:      ## остановить контейнеры, данные сохраняются
	@docker compose --profile '*' stop

ps:        ## показать состояние контейнеров
	@docker compose --profile '*' ps --format 'table {{.Name}}\t{{.Status}}\t{{.Ports}}'

logs:      ## последние строки логов Kafka
	@docker compose logs --tail 50 kafka

reset:     ## удалить контейнеры и ВСЕ данные стенда
	@test "$(CONFIRM)" = "yes" || (echo "Удалит все топики и таблицы. Запустите: make reset CONFIRM=yes"; exit 1)
	docker compose --profile '*' down -v

cluster-up:      ## учебный кластер: контроллер и три брокера (M02, M11)
	@docker compose -f cluster/compose.yaml up -d --wait --wait-timeout 180
	@echo "Кластер запущен: localhost:29092, localhost:29093, localhost:29094"

cluster-down:    ## остановить кластер, данные сохраняются
	@docker compose -f cluster/compose.yaml stop

cluster-ps:      ## состояние контейнеров кластера
	@docker compose -f cluster/compose.yaml ps -a --format 'table {{.Name}}\t{{.Status}}\t{{.Ports}}'

cluster-reset:   ## удалить кластер вместе с данными
	@test "$(CONFIRM)" = "yes" || (echo "Удалит все данные кластера. Запустите: make cluster-reset CONFIRM=yes"; exit 1)
	@docker compose -f cluster/compose.yaml down -v

secure-up:       ## защищённый брокер с SASL и ACL (урок m11_l03)
	@docker compose -f secure/compose.yaml up -d --wait --wait-timeout 180
	@echo "Защищённый брокер: localhost:39092 (SASL/PLAIN)"

secure-down:     ## остановить защищённый брокер
	@docker compose -f secure/compose.yaml stop
