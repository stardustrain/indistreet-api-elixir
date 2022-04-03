defmodule IndistreetApiWeb.V1.UserController do
  @moduledoc false

  use IndistreetApiWeb, :controller
  alias IndistreetApi.V1.Account

  action_fallback IndistreetApiWeb.FallbackController

  def signin(conn, %{"email" => email, "password" => password}) do
    with {:ok, token, _claims} <- Account.sign_in!(email, password) do
      conn
      |> render("signin.json", token: token)
    else
      {:error, :unauthorized} -> {:error, :unauthorized, "Unauthorized"}
    end
  end

  def signup(conn, %{"email" => email, "password" => password}) do
    
  end
end
