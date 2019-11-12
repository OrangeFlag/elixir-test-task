defmodule ElixirExample.MixProject do
  use Mix.Project

  def project do
    [
      app: :url_history_server,
      version: "0.1.0",
      elixir: "~> 1.9",
      start_permanent: Mix.env() == :prod,
      deps: deps(),
      escript: escript()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger],
      mod: {UrlHistory.Application, []}
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:poison, "~> 4.0.1"},
      {:plug, "~> 1.8.3"},
      {:cowboy, "~> 2.7"},
      {:plug_cowboy, "~> 2.1"},
      {:redix, "~> 0.10.2"},
      {:earmark, "~> 1.4", only: :dev},
      {:ex_doc, "~> 0.21", only: :dev},
      {:dialyxir, "~> 0.4", only: :dev}
    ]
  end

  defp escript do
    [main_module: UrlHistory.Application]
  end
end
