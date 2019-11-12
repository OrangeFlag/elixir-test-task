defmodule UrlHistory.Repository.Redis do
  def add(scored_set) when is_nil(scored_set), do: {:error, "links is nill"}

  def add(scored_set) do
    Redix.command(:redix, ["ZADD", "links" | scored_set])
  end

  def get(from, to) when is_nil(from) or is_nil(to),
    do: {:error, "error: from or to is nill"}

  def get(from, to) do
    Redix.command(:redix, ["ZRANGEBYSCORE", "links", from, to])
  end
end
