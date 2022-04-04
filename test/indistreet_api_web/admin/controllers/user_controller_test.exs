defmodule IndistreetApiWeb.Admin.UserControllerTest do
  use IndistreetApiWeb.ConnCase

  import IndistreetApi.UserFixture
  alias IndistreetApi.Guardian

  setup %{conn: conn} do
    {:ok, conn: conn |> put_req_header("accept", "application/json")}
  end

  describe "toggle user authorization" do
    setup [:create_user, :create_admin_token]

    test "should render toggle result with user information", %{conn: conn, user: user, admin_token: token} do
      conn = conn |> put_req_header("authorization", "Bearer #{token}")

      conn = patch(
        conn,
        Routes.admin_user_path(conn, :toggle_user_authorization, user.id)
      )

      assert json_response(conn, 200)
      assert json_response(conn, 200)["id"] === user.id
      assert json_response(conn, 200)["is_admin"] === true
      refute json_response(conn, 200) |> Map.has_key?("password_hash")
    end

    test "should render 401 error with invalid jwt token", %{conn: conn, user: user} do
      conn = conn |> put_req_header("authorization", "Bearer INVALID_TOKEN")

      conn = patch(
        conn,
        Routes.admin_user_path(conn, :toggle_user_authorization, user.id)
      )

      assert json_response(conn, 401)
    end
  end

  defp create_user(_) do
    user = user_fixture()
    %{user: user}
  end

  defp create_admin_token(_) do
    admin = admin_user_fixture()
    {:ok, token, _claims} = Guardian.encode_and_sign(admin)
    %{admin_token: token}
  end
end
