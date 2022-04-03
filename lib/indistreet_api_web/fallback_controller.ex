defmodule IndistreetApiWeb.FallbackController do
  @moduledoc false

  use Phoenix.Controller

  alias IndistreetApiWeb.ErrorHelpers

  def call(conn, {:error, status_code, message}) when is_binary(message) do
    conn
    |> put_status(status_code)
    |> put_view(IndistreetApiWeb.ErrorView)
    |> render("error.json", %{detail: message})
  end

  def call(conn, {:error, status_code, %Ecto.Changeset{} = changeset}) do
    detail = changeset
    |> Ecto.Changeset.traverse_errors(&ErrorHelpers.translate_error(&1))

    conn
    |> put_status(status_code)
    |> put_view(IndistreetApiWeb.ErrorView)
    |> render("error.json", %{detail: detail})
  end
end

