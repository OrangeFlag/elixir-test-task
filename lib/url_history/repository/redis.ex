defmodule UrlHistory.Repository.Redis do
  @module Application.get_env(:url_history_server, :redis)[:module]

  @type scored_set() :: [String.t()]
  @type unix_time() :: integer()

  @callback add(scored_set()) :: {:ok, term} | {:error, term}
  @callback get(unix_time(), unix_time()) :: {:ok, term} | {:error, term}

  def add(scored_set) when is_nil(scored_set), do: {:error, "links is nill"}

  def add(scored_set) do
    @module.add(scored_set)
  end

  def get(from, to) when is_nil(from) or is_nil(to),
    do: {:error, "error: from or to is nill"}

  def get(from, to) do
    @module.get(from, to)
  end
end
