defmodule IndistreetApiWeb.V1.UserControllerTest do
  @moduledoc false
  
  use IndistreetApiWeb.ConnCase

  import IndistreetApi.UserFixture
  alias IndistreetApi.Guardian

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "user sign in" do
    test "should render jwt token with valid user", %{conn: conn} do
      user_attrs = %{email: "test@test.com", password: "test1234"}
      user = user_fixture(user_attrs)

      conn = post(
        conn,
        Routes.v1_user_path(conn, :signin),
        user_attrs
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
      conn = post(conn, Routes.v1_user_path(conn, :signup), %{email: "", password: ""})
      assert json_response(conn, 400)
    end
  end
end
