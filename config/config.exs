use Mix.Config

config :url_history_server, cowboy_port: 8080

config :url_history_server, :redis, module: UrlHistory.Repository.Redis.Impl

config :url_history_server, cowboy_port: (System.get_env("PORT") || "8080") |> String.to_integer()

config :url_history_server, redis_host: System.get_env("REDIS_URL") || "redis://localhost:6379"

import_config "#{Mix.env()}.exs"
