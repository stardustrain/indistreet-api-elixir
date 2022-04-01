defmodule IndistreetApi.V1.AccountTest do
  use IndistreetApi.DataCase

  alias IndistreetApi.V1.Account

  describe "users" do
    alias IndistreetApi.Model.Account.User
    alias IndistreetApi.Guardian

    import IndistreetApi.UserFixture

    test "get_user_by_id!/1 return user with id" do
      user_fixture(%{email: "test@test.com"})

      user = Account.get_user_by_id!(1)
      assert user.id === 1
      assert user.email === "test@test.com"
    end

    test "create_user!/1 creates a user with valid data" do
      valid_attrs = %{email: "test@test.com", password: "test1234"}

      {:ok, %User{} = user} = Account.create_user(valid_attrs)
      assert user.email === valid_attrs.email
    end

    test "sign_in!/2 return user with valid email and password" do
      valid_attrs = %{email: "test@test.com", password: "test1234"}
      user = user_fixture(valid_attrs)

      {:ok, token, _} = Account.sign_in!(valid_attrs.email, valid_attrs.password)
      {:ok, claims} = Guardian.decode_and_verify(token)

      assert claims["sub"] === user.id |> to_string
    end
  end
end
