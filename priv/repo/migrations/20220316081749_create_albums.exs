defmodule IndistreetApi.Repo.Migrations.CreateAlbums do
  use Ecto.Migration

  def change do
    create table(:albums) do
      add :name, :string
      add :album_type, :string
      add :description, :string

      timestamps()
    end
  end
end
