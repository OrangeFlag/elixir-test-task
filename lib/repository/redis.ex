defmodule UrlHistory.Repository.Redis do
  def add(links) when is_nil(links), do: {:error, "links is nill"}

  def add(links) do
    time = DateTime.utc_now() |> DateTime.to_unix()
    Redix.command(:redix, ["ZADD", "links" | Enum.flat_map(links, fn link -> [time, link] end)])
  end

  def get(from, to) when is_nil(from) or is_nil(to),
    do: {:error, "error: from or to is nill"}

  def get(from, to) do
    Redix.command(:redix, ["ZRANGEBYSCORE", "links", from, to])
  end
end
