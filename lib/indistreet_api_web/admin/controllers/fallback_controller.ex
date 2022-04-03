defmodule IndistreetApiWeb.Admin.FallbackController do
  @moduledoc false

  use Phoenix.Controller

  alias IndistreetApiWeb.ErrorHelpers

  def call(conn, {:error, status_code, changeset}) do
    detail = changeset
    |> Ecto.Changeset.traverse_errors(&ErrorHelpers.translate_error(&1))

    conn
    |> put_status(status_code)
    |> put_view(IndistreetApiWeb.ErrorView)
    |> render("error.json", %{detail: detail})
  end
end

