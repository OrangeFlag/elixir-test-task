defmodule UrlHistory.Application do
  use Application

  def start(_type, _args) do
    Supervisor.start_link(children(), strategy: :one_for_one)
  end

  defp children do
    [
      UrlHistory.Server.Endpoints,
      {Redix, host: "localhost", name: :redix}
    ]
  end
end
