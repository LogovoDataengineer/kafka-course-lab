# Стенд курса «Kafka для дата-инженера»

Учебный стенд курса: Kafka 4.1 (KRaft), Kafbat UI, PostgreSQL-хранилище, Schema Registry, Kafka Connect с Debezium, Prometheus и Grafana, Airflow. Всё запускается в GitHub Codespaces одной командой.

## Как начать

1. Нажмите **Use this template** → **Create a new repository**, назовите репозиторий `kafka-course-lab` и сделайте его **Private**.
2. В своём репозитории: **Code** → **Codespaces** → **Create codespace on main**. Первая сборка занимает 2–5 минут.
3. В терминале Codespace:

```bash
make up
```

4. Kafbat UI откроется на вкладке **PORTS**, порт **18080**.

Подробно каждый шаг разобран в уроке m00_l00 курса.

## Основные команды

| Команда | Что делает |
|---|---|
| `make up` | запустить Kafka и Kafbat UI |
| `make up PROFILES="dwh connect cdc"` | запустить ещё и сервисы, нужные уроку (профили указаны в начале урока) |
| `make ps` | состояние контейнеров |
| `make down` | остановить стенд, данные сохраняются |
| `make reset CONFIRM=yes` | удалить все данные стенда и начать с нуля |

Закончили заниматься — остановите сам Codespace на https://github.com/codespaces, иначе он расходует квоту.
