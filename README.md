# Elixir test task

## Deployed
Сервис раскатан на heroku и доступен по адресу:   
[elixir-test-task.herokuapp.com](https://elixir-test-task.herokuapp.com/visited_domains?from=1&to=2234567876543)


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

## Launch configuration
Конфигурации находятся в [config](config)