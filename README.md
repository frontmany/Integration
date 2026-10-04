# Синхронизация деталей CMS, БД исторических данных и Report API

Курсовая работа по дисциплине Интеграция систем. Реализовано на n8n и PostgreSQL.

Спецификация API: http://77.67.89.207:8080/swagger-ui/index.html

## Workflow

![Workflow](docs/screenshots/workflow.png)

1. Get Token получает Bearer токен для Report API. Логин и пароль берутся из `.env`.
2. Get CMS Spares забирает все страницы `/cms/spares` с пагинацией, пока не придёт пустая страница.
3. Get DB Spares читает таблицу `spares_history`.
4. Sync CMS and DB Spares сравнивает наборы по `spareCode` и определяет, какие детали добавить, обновить и пометить удалёнными.
5. Insert New Spares, Update Changed Spares и Soft Delete Spares применяют изменения к БД. Удалённые из CMS детали остаются в БД с флагом `is_deleted`.
6. Select Active For Report выбирает актуальные детали (`is_deleted = FALSE`).
7. Build CSV Lines и Convert to CSV формируют файл: UTF8 без BOM, без заголовка, разделитель `;`.
8. Send CSV Report отправляет файл в `/report/csv`.

Workflow запускается вручную или по расписанию раз в 6 часов.

## Результат

![Результат](docs/screenshots/result.png)

## Запуск

1. Скопировать `.env.example` в `.env` и заполнить.
2. Выполнить `docker compose up -d`.
3. Открыть http://localhost:5678 и импортировать `workflow.json`.
4. Создать credentials HTTP Basic Auth для CMS и Postgres для БД (хост `postgres`).
5. Нажать Execute workflow или опубликовать workflow для запуска по расписанию.

Таблица БД создаётся автоматически из `init.sql`.

Проверка оценки: http://77.67.89.207:8080/students/24/results
