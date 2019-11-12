use Mix.Config

config :url_history_server, UrlHistory.Server.Endpoints, port: System.get_env("PORT")

config :url_history_server, UrlHistory.Application, [redis_host: System.get_env("REDIS_URL"), redis_port: 6379]