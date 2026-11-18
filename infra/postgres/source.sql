-- База-источник сервиса заказов (модуль M08). Выполняется один раз при первом запуске контейнера source.
CREATE TABLE customers (
    customer_id integer PRIMARY KEY,
    name        text    NOT NULL,
    city        text    NOT NULL
);
CREATE TABLE orders (
    order_id    integer     PRIMARY KEY,
    customer_id integer     NOT NULL REFERENCES customers,
    amount      integer     NOT NULL,
    status      text        NOT NULL,
    updated_at  timestamptz NOT NULL DEFAULT now()
);
INSERT INTO customers SELECT n, 'Клиент ' || n, (ARRAY['Москва', 'Казань', 'Пермь'])[1 + n % 3] FROM generate_series(1, 10) n;
INSERT INTO orders (order_id, customer_id, amount, status)
SELECT n, 1 + n % 10, n * 100, 'new' FROM generate_series(1, 50) n;
