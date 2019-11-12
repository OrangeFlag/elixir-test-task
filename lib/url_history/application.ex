defmodule UrlHistory.Application do
  use Application
  require Logger

  def start(_type, _args) do
    Logger.info("Server run in port: #{cowboy_port()}")
    Logger.info("Redix connect to #{redis_config()[:host]}:#{redis_config()[:port]}")

    Supervisor.start_link(children(), opts())
  end

  defp children do
    [
      {Plug.Cowboy,
       scheme: :http, plug: UrlHistory.Server.Endpoints, options: [port: cowboy_port()]},
      {Redix, host: "#{redis_config()[:host]}:#{redis_config()[:port]}", name: :redix}
    ]
  end

  defp opts do
    [strategy: :one_for_one, name: UrlHistory.Application.Supervisor]
  end

  defp cowboy_port do
    Application.get_env(:url_history_server, :cowboy_port)
  end

  defp redis_config do
    Application.get_env(:url_history_server, :redis_config)
  end
end
