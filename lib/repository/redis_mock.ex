defmodule UrlHistory.Repository.Redis.Mock do
  @behaviour UrlHistory.Repository.Redis

  def init() do
    Agent.start_link(fn -> [] end, name: RedisMockState)
  end

  def clear() do
    Agent.update(RedisMockState, fn _ -> [] end)
  end

  @impl true
  def add([]), do: {:error, "links is nill"}

  @impl true
  def add(first = [_ | second]) do
    scored_set = Enum.zip(first |> Enum.take_every(2), second |> Enum.take_every(2))
    Agent.update(RedisMockState, fn state -> state ++ scored_set end)

    {:ok, nil}
  end

  @impl true
  def get(from, to) do
    result =
      Agent.get(RedisMockState, & &1)
      |> Enum.filter(fn {key, _} -> key >= from and key <= to end)
      |> Enum.map(fn {_, value} -> value end)

    {:ok, result}
  end
end
