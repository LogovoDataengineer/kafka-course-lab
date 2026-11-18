-- Схема учебного хранилища (DWH). Выполняется один раз при первом запуске контейнера dwh.
-- Таблица событий: одна строка на одно событие Wikimedia.
CREATE TABLE events (
    event_id   text PRIMARY KEY,          -- уникальный идентификатор события
    entity_id  text NOT NULL,             -- какая страница изменилась: "<wiki>:<title>"
    version    bigint NOT NULL,           -- номер ревизии страницы после правки
    payload    jsonb NOT NULL,            -- остальные поля события
    kafka_topic     text NOT NULL,        -- откуда событие прочитано: топик,
    kafka_partition integer NOT NULL,     -- партиция
    kafka_offset    bigint NOT NULL,      -- и offset
    loaded_at  timestamptz NOT NULL DEFAULT now()
);
