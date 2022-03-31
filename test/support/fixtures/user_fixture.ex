defmodule IndistreetApi.UserFixture do
  @moduledoc false

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
end
