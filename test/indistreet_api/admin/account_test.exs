defmodule IndistreetApi.Admin.AccountTest do
  use IndistreetApi.DataCase
  
  alias IndistreetApi.Admin.Account
  import IndistreetApi.UserFixture

  describe "users" do
    test "toggle_user_authorization/1 toggle is_admin flag for user" do
      %{user: user} = create_user()

      {:ok, user} = Account.toggle_user_authorization(user)
      assert user.is_admin === true
      {:ok, user} = Account.toggle_user_authorization(user)
      assert user.is_admin === false
    end
  end

  defp create_user() do
    user = user_fixture()
    %{user: user}
  end
end
