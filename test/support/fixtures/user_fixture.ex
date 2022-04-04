defmodule IndistreetApi.UserFixture do
  @moduledoc false

  alias IndistreetApi.Guardian

  def user_fixture(attrs \\ %{}) do
    {:ok, user} =
      attrs
      |> Enum.into(%{
        email: "test@test.com",
        password: "test1234"
      })
      |> IndistreetApi.V1.Account.create_user

    user
  end

  def admin_user_fixture(attrs \\ %{}) do
    {:ok, admin} =
      attrs
      |> Enum.into(%{
        email: "admin@test.com",
        password: "test1234",
        is_admin: true
      })
      |> IndistreetApi.V1.Account.create_user

      admin
  end

  def admin_user_token_fixture(attrs \\ %{}) do
    admin = admin_user_fixture()
    {:ok, token, _claims} = Guardian.encode_and_sign(admin)

    token
  end
end
