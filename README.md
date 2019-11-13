# Elixir test task

## Deployed
Сервис раскатан на heroku и доступен по адресу:   
[elixir-test-task.herokuapp.com](https://elixir-test-task.herokuapp.com/)


## Installation
Получение зависимостей:
```bash
mix deps.get
```

Запуск:
```bash
mix run --no-halt
```
В Dev среде сервис запускается на порту 8080 и требует запущенной БД Redis на порту 6379

## Конфигурация запуска
Конфигурации находятся в [config](config)