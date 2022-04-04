defmodule IndistreetApi.Admin.Account do
  @moduledoc false

  import Ecto.Query
  alias IndistreetApi.Repo
  alias IndistreetApi.Model.Account.User

  def toggle_user_authorization(user) do
    user
    |> Ecto.Changeset.change(is_admin: !user.is_admin)
    |> Repo.update
  end
end
