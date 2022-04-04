defmodule IndistreetApi.Plugs.Authorization do
  @moduledoc false

  import Plug.Conn
  alias IndistreetApiWeb.ErrorView

  def init(_) do
  end

  def call(conn, _) do
    user = conn.private.guardian_default_resource

    if (user.is_admin) do
      conn
    else
      body = ErrorView.template_not_found("403.json", "") |> Jason.encode!

      conn
      |> put_resp_content_type("application/json")
      |> send_resp(:forbidden, body)
      |> halt
    end
  end
end
