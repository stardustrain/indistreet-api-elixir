defmodule IndistreetApiWeb.Admin.FallbackController do
  @moduledoc false

  use Phoenix.Controller

  def call(conn, {:error, :bad_request}) do
    conn
    |> put_status(400)
    |> put_view(IndistreetApiWeb.ErrorView)
    |> render(:"400")
  end

  def call(conn, {:error, :unprocessable_entity}) do
    conn
    |> put_status(422)
    |> put_view(IndistreetApiWeb.ErrorView)
    |> render(:"422")
  end
end
