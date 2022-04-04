defmodule IndistreetApiWeb.Admin.UserController do
  @moduledoc false

  use IndistreetApiWeb, :controller
  alias IndistreetApi.Admin.Account

  action_fallback IndistreetApiWeb.FallbackController

  def toggle_user_authorization(conn, %{"id" => id}) do
    with user <- IndistreetApi.V1.Account.get_user_by_id!(id),
         {:ok, user} <- Account.toggle_user_authorization(user) do

      conn
      |> render("user.json", %{user: user})
    end
  end
end
