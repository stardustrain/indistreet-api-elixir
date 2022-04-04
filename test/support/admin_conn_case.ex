defmodule IndistreetApiWeb.AdminConnCase do
  @moduledoc false

  defmacro __using__(_opts) do
    quote do
      use IndistreetApiWeb.ConnCase
      import IndistreetApi.UserFixture

      setup %{conn: conn} do
        token = admin_user_token_fixture()
        conn = conn
               |> put_req_header("accept", "application/json")
               |> put_req_header("authorization", "Bearer #{token}")
        {:ok, conn: conn}
      end
    end
  end
end
