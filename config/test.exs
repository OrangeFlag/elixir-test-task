use Mix.Config

config :url_history_server, :redis, module: UrlHistory.Repository.Redis.Mock
