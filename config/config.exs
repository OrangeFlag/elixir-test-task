use Mix.Config

config :url_history_server, cowboy_port: 8080

config :url_history_server, :redis, module: UrlHistory.Repository.Redis.Impl

config :logger, level: :debug

import_config "#{Mix.env()}.exs"
