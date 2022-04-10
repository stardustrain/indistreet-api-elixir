defmodule IndistreetApi.V1.Account do
  @moduledoc false

  import Pbkdf2, only: [check_pass: 2]
  alias IndistreetApi.Repo
  alias IndistreetApi.Model.Account.User
  alias IndistreetApi.Guardian

  def create_user(attrs \\ %{}) do
    %User{}
    |> User.changeset(attrs)
    |> Repo.insert
  end

  def get_user_by_id!(id) do
    User
    |> Repo.get!(id)
  end

  defp get_user_by_email(email) do
    case User |> Repo.get_by(email: email) do
      nil -> {:error, :notfound}
      user -> {:ok, user}
    end
  end

  def sign_in(email, password) do
    with {:ok, user} <- get_user_by_email(email),
         {:ok, user} <- check_pass(user, password) do
      Guardian.encode_and_sign(user)
    else
      {:error, _reason} -> {:error, :unauthorized}
    end
  end

  def sign_up(attrs \\ %{}) do
    with {:ok, user} <- create_user(attrs) do
      Guardian.encode_and_sign(user)
    end
  end
end
