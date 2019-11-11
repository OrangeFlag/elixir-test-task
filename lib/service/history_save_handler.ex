defmodule UrlHistory.Service.HistorySaveHandler do
  import UrlHistory.Utils.Random

  def save_links(links) when is_nil(links), do: {:error, "links is nill"}

  def save_links(links) do
    links
    |> Enum.map(fn x -> x <> "///#{random_string(5)}" end)
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