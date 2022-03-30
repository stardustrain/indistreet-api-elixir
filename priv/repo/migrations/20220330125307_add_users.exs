defmodule IndistreetApi.Repo.Migrations.AddUsers do
  use Ecto.Migration

  def change do
    create table(:users) do
      add :email, :string
      add :password_hash, :string
      add :is_admin, :boolean
      add :is_super_user, :boolean
      timestamps()

      unique_index(:users, [:email], unique: true)
    end
  end
end
