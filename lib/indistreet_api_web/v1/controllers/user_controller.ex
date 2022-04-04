defmodule IndistreetApiWeb.V1.UserController do
  @moduledoc false

  use IndistreetApiWeb, :controller
  alias IndistreetApi.V1.Account
  alias IndistreetApi.Guardian

  action_fallback IndistreetApiWeb.FallbackController

  def signin(conn, %{"email" => email, "password" => password}) do
    with {:ok, token, _claims} <- Account.sign_in(email, password) do
      conn
      |> render("jwt.json", token: token)
    end
  end

  def signup(conn, %{"email" => email, "password" => password}) do
    with {:ok, token, _claims} <- Account.sign_up(%{email: email, password: password}) do
      conn
      |> put_status(:created)
      |> render("jwt.json", token: token)
    end
  end

  def me(conn, _) do
    user = Guardian.Plug.current_resource(conn)

    conn
    |> render("me.json", user: user)
  end
end
