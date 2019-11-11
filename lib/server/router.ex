defmodule UrlHistory.Server.Router do
  use Plug.Router

  plug(:match)
  plug(:dispatch)

  post "/visited_links" do
    conn = conn |> json_conn
      with %{"links" => links} <- conn.body_params,
           {:ok, _} <- UrlHistory.Repository.Redis.insert(links) do
            send_resp(conn, 201, %{status: "ok"} |> Poison.encode!)
      else
        {:error, error} -> send_resp(conn, 500, %{status: error} |> Poison.encode!())
        _ -> send_resp(conn, 500, %{status: "error"} |> Poison.encode!())
      end
  end

  get "/visited_domains" do
    result =
      with from <- conn.params["from"],
           to <- conn.params["to"],
           {:ok, domains} <- UrlHistory.Repository.Redis.get_domains(from, to) do
        %{domains: domains, status: "ok"}
      else
        {:error, error} -> %{status: error}
        _ -> %{status: "error"}
      end

    conn
    |> json_conn
    |> send_resp(200, result |> Poison.encode!())
  end

  match _ do
    send_resp(conn, 404, "Page not found")
  end

  defp json_conn(conn) do
    conn
    |> put_resp_content_type("application/json")
  end
end
