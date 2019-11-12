defmodule UrlHistory.Server.EndpointsTest do
  use ExUnit.Case, async: true
  use Plug.Test

  alias UrlHistory.Server.Endpoints
  alias UrlHistory.Repository.Redis.Mock, as: RedisMock

  @init Endpoints.init([])

  setup_all do
    RedisMock.init()
    {:ok, []}
  end

  test "post /visited_links" do
    body_params = %{links: ["http://www.ya.ru"]}

    conn =
      conn(:post, "/visited_links", body_params)
      |> Endpoints.call(@init)

    assert conn.status == 201
  end

  test "post empty list /visited_links" do
    body_params = %{links: []}

    conn =
      conn(:post, "/visited_links", body_params)
      |> Endpoints.call(@init)

    assert conn.status == 500
  end

  test "post empty body /visited_links" do
    body_params = %{}

    conn =
      conn(:post, "/visited_links", body_params)
      |> Endpoints.call(@init)

    assert conn.status == 500
  end

  test "get /" do
    conn =
      conn(:get, "/")
      |> Endpoints.call(@init)

    assert conn.status == 404
  end

  test "get /visited_domains without params" do
    conn =
      conn(:get, "/visited_domains")
      |> Endpoints.call(@init)

    assert conn.status == 500
  end

  test "get /visited_domains with params" do
    from = 1
    to = 2

    conn =
      conn(:get, "/visited_domains?from=#{from}&to=#{to}")
      |> Endpoints.call(@init)

    assert conn.status == 200
  end
end
