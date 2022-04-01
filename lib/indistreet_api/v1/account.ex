defmodule IndistreetApi.V1.Account do
  @moduledoc false

  import Ecto.Query
  alias IndistreetApi.Repo
  alias IndistreetApi.Model.Account.User

  def create_user(attrs \\ %{}) do
    %User{}
    |> User.changeset(attrs)
    |> Repo.insert
  end

  def get_user_by_id!(id) do
    User
    |> Repo.get!(id)
  end
end
