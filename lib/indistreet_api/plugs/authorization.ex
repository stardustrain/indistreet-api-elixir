defmodule IndistreetApi.Plugs.Authorization do
  @moduledoc false

  import Plug.Conn
  alias IndistreetApiWeb.ErrorView
  alias IndistreetApi.Guardian

  def init(_) do
  end

  defp send_forbidden_error(conn) do
    body = ErrorView.template_not_found("403.json", %{}) |> Jason.encode!

    conn
    |> put_resp_content_type("application/json")
    |> send_resp(:forbidden, body)
  end

  def call(conn, _) do
    is_admin = Guardian.Plug.current_resource(conn) |> Map.fetch(:is_admin)

    case is_admin do
      {:ok, true} -> conn
      _ -> conn |> send_forbidden_error |> halt
    end
  end
end
