defmodule UrlHistory.Service.HistorySaveHandler do

  def save_links(links) when is_nil(links), do: {:error, "links is nill"}

  def save_links(links) do
    time = DateTime.utc_now() |> DateTime.to_unix()

    links
    |> Enum.map(fn x -> x <> "///#{time}" end)
    |> Enum.flat_map(fn link -> [time, link] end)
    |> UrlHistory.Repository.Redis.add()
  end

  def get_domains(from, to) when is_nil(from) or is_nil(to), do: {:error, "from or to is nill"}

  @regex ~r/^(([^:\/?#]+):\/\/)?([^\/?#]*)?([^?#]*)(\?([^#]*))?(#(.*))?$/u

  def get_domains(from, to) do
    with {:ok, links} <- UrlHistory.Repository.Redis.get(from, to) do
      result =
        links
        |> Enum.map(fn x -> Regex.scan(@regex, x) |> Enum.at(0, []) |> Enum.at(3) end)
        |> Enum.filter(fn x -> not is_nil(x) end)
        |> Enum.uniq()

      {:ok, result}
    else
      err -> err
    end
  end
end
