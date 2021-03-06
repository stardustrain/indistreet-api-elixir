defmodule IndistreetApi.Model.Account.User do
  @moduledoc false

  use IndistreetApi.Schema
  import Pbkdf2, only: [hash_pwd_salt: 1]

  @derive {Jason.Encoder, except: [:__meta__, :password, :password_confirmation, :password_hash]}
  schema "users" do
    field :email, :string
    field :password_hash, :string
    field :is_admin, :boolean, default: false
    field :is_super_user, :boolean, default: false

    field :password, :string, virtual: true
    field :password_confirmation, :string, virtual: true

    timestamps()
  end

  def changeset(user, attrs) do
    user
    |> cast(attrs, [:email, :password, :is_admin, :is_super_user])
    |> validate_required([:email, :password, :is_admin, :is_super_user])
    |> unique_constraint(:email)
    |> validate_length(:password, min: 8)
    |> validate_confirmation(:password)
    |> put_password_hash
  end

  defp put_password_hash(changeset) do
    case changeset do
      %Ecto.Changeset{valid?: true, changes: %{password: password}}
        -> put_change(changeset, :password_hash, hash_pwd_salt(password))
      _ -> changeset
    end
  end

end
