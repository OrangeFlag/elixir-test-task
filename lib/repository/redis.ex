defmodule UrlHistory.Repository.Redis do
  def insert(links) when is_nil(links), do: {:error, "links is nill"}

  def insert(links) do
    time = DateTime.utc_now() |> DateTime.to_unix()
    Redix.command(:redix, ["ZADD", "links" | Enum.flat_map(links, fn link -> [time, link] end)])
  end

  def get_domains(from, to) when is_nil(from) or is_nil(to),
    do: {:error, "error: from or to is nill"}

  def get_domains(from, to) do
    Redix.command(:redix, ["ZRANGEBYSCORE", "links", from, to])
  end
end
