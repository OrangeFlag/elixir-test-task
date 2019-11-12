use Mix.Config

config :url_history_server, cowboy_port: System.get_env("PORT")

config :url_history_server, redis_host: System.get_env("REDIS_URL")
