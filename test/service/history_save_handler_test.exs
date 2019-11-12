defmodule UrlHistory.Service.HistorySaveHandlerTest do
  use ExUnit.Case

  alias UrlHistory.Service.HistorySaveHandler, as: History
  alias UrlHistory.Repository.Redis.Mock, as: RedisMock

  setup do
    RedisMock.init()
    {:ok, []}
  end

  test "get domains" do
    History.save_links(
      [
        "https://ya.ru",
        "https://ya.ru?q=123",
        "funbox.ru",
        "https://stackoverflow.com/questions/11828270/how-to-exit-the-vim-editor"
      ],
      1
    )

    pattern =
      {:ok,
       [
         "ya.ru",
         "funbox.ru",
         "stackoverflow.com"
       ]}

    assert History.get_domains(1, 1) == pattern

    RedisMock.clear()
  end

  test "get domains from and to params" do
    History.save_links(
      ["https://ya.ru"],
      1
    )

    History.save_links(
      ["https://ya.ru?q=123"],
      2
    )

    History.save_links(
      ["funbox.ru"],
      3
    )

    History.save_links(
      ["https://stackoverflow.com/questions/11828270/how-to-exit-the-vim-editor"],
      4
    )

    assert is_list_equals(History.get_domains(1, 2) |> elem(1), ["ya.ru"])

    assert is_list_equals(History.get_domains(3, 4) |> elem(1), ["funbox.ru", "stackoverflow.com"])

    assert is_list_equals(History.get_domains(2, 3) |> elem(1), ["funbox.ru", "ya.ru"])

    RedisMock.clear()
  end

  defp is_list_equals(first, second), do: first -- second == []
end
