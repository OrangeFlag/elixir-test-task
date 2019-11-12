defmodule UrlHistory.Repository.Redis do
  use GenServer

  ### GenServer API

  def init(state) do
    redis = Keyword.get(state, :redis, Redix)
    {:ok, %{redis: redis}}
  end

  def handle_call({:add, scored_set}, _from, state) when is_nil(scored_set),
    do: {:reply, {:error, "scored_set must not be nil"}, state}

  def handle_call({:add, scored_set}, _from, state) do
    result = state.redis.command(:redix, ["ZADD", "links" | scored_set])
    {:reply, result, state}
  end

  def handle_call({:get, from, to}, _from, state) when is_nil(from) or is_nil(to),
    do: {:reply, {:error, "from or to is nill"}, state}

  def handle_call({:get, from, to}, _from, state) do
    result = state.redis.command(:redix, ["ZRANGEBYSCORE", "links", from, to])
    {:reply, result, state}
  end

  ### Client API

  def start_link(state \\ %{}) do
    opts = Keyword.get(state, :opts, [])
    GenServer.start_link(__MODULE__, state, [name: __MODULE__] ++ opts)
  end

  def add(scored_set) do
    GenServer.call(__MODULE__, {:add, scored_set})
  end

  def get(from, to) do
    GenServer.call(__MODULE__, {:get, from, to})
  end
end
