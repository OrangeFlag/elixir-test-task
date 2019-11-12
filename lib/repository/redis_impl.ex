defmodule UrlHistory.Repository.Redis.Impl do
  @behaviour UrlHistory.Repository.Redis

  @impl true
  def add(scored_set) do
    Redix.command(:redix, ["ZADD", "links" | scored_set])
  end

  @impl true
  def get(from, to) do
    Redix.command(:redix, ["ZRANGEBYSCORE", "links", from, to])
  end
end
