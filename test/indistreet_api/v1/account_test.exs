defmodule IndistreetApi.V1.AccountTest do
  use IndistreetApi.DataCase

  alias IndistreetApi.V1.Account

  describe "users" do
    alias IndistreetApi.Model.Account.User

    import IndistreetApi.UserFixture

    test "get_user!/1 return user with id" do
      user_fixture(%{email: "test@test.com"})

      user = Account.get_user!(1)
      assert user.id === 1
      assert user.email === "test@test.com"
    end

    test "create_user!/1 creates a user with valid data" do
      valid_attrs = %{email: "test@test.com", password: "test1234"}

      {:ok, %User{} = user} = Account.create_user(valid_attrs)
      assert user.email === valid_attrs.email
    end
  end
end
