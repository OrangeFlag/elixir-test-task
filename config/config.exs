use Mix.Config

config :url_history_server, UrlHistory.Server.Endpoints, port: 8080

config :url_history_server, :redis, module: UrlHistory.Repository.Redis.Impl

import_config "#{Mix.env()}.exs"
