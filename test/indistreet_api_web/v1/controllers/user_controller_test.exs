defmodule IndistreetApiWeb.V1.UserControllerTest do
  @moduledoc false
  
  use IndistreetApiWeb.ConnCase

  import IndistreetApi.UserFixture
  alias IndistreetApi.Guardian

  @user_attrs %{email: "test@test.com", password: "test1234"}

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "user sign in" do
    setup [:create_user]

    test "should render jwt token with valid user", %{conn: conn, user: user} do
      conn = post(
        conn,
        Routes.v1_user_path(conn, :signin),
        @user_attrs
      )

      %{"token" => token} = json_response(conn, 200)
      {:ok, claims} = Guardian.decode_and_verify(token)

      assert claims["sub"] === user.id |> to_string
    end

    test "should render 401 with invalid attributes", %{conn: conn} do
      invalid_attrs = %{email: "invalid@test.com", password: "test1234"}

      conn = post(
        conn,
        Routes.v1_user_path(conn, :signin),
        invalid_attrs
      )

      assert json_response(conn, 401)["errors"]["detail"] === "Unauthorized"
    end
  end

  describe "user sign up" do
    test "should render jwt token with valid attrs", %{conn: conn} do
      user_attrs = %{email: "test@test.com", password: "test1234"}

      conn = post(
        conn,
        Routes.v1_user_path(conn, :signup),
        user_attrs
      )

      assert %{"token" => token} = json_response(conn, 201)
      assert is_binary(token)
    end

    test "should render 400 with invalid attributes", %{conn: conn} do
      create_user(nil)

      conn = post(conn, Routes.v1_user_path(conn, :signup), %{email: "", password: ""})
      assert json_response(conn, 400)

      conn = post(conn, Routes.v1_user_path(conn, :signup), %{email: "other-mail@test.com", password: "짧은암호"})
      assert json_response(conn, 400)

      conn = post(conn, Routes.v1_user_path(conn, :signup), @user_attrs)
      assert json_response(conn, 400)
    end
  end

  describe "retrieve user" do
    setup [:create_user]

    test "should render user information with valid jwt token", %{conn: conn} do
      login_response = post(
        conn,
        Routes.v1_user_path(conn, :signin),
        @user_attrs
      )

      %{"token" => token} = json_response(login_response, 200)

      conn = conn |> put_req_header("authorization", "Bearer #{token}")
      conn = get(
        conn,
        Routes.v1_user_path(conn, :me)
      )

      assert json_response(conn, 200)
      keys = json_response(conn, 200) |> Map.keys

      assert keys
             |> Enum.all?(fn key -> Enum.member?(["id", "email", "inserted_at", "updated_at"], key)  end)
      refute keys
             |> Enum.all?(fn key -> Enum.member?(["is_admin", "is_super_user"], key)  end)
    end

    test "should render 401 with invalid jwt token", %{conn: conn} do
      conn = get(
        conn,
        Routes.v1_user_path(conn, :me)
      )

      assert json_response(conn, 401)
    end
  end

  defp create_user(_) do
    user = user_fixture(@user_attrs)
    %{user: user}
  end
end
