defmodule IndistreetApi.Repo.Migrations.CreateSongs do
  use Ecto.Migration

  def change do
    create table(:songs) do
      add :name, :string
      add :album_id, references(:albums, on_delete: :delete_all)
      timestamps()
    end
  end
end
