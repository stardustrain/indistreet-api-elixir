defmodule IndistreetApi.Album do
  use Ecto.Schema
  import Ecto.Changeset
  import Ecto.Query, warn: false
  alias IndistreetApi.{Repo, Album}

  schema "albums" do
    field :name, :string
    field :album_type, :string
    field :description, :string

    timestamps()
  end

  def list_albums do
    Repo.all(Album)
  end

  def get_product!(id) do
    Repo.one!(from album in Album, where: album.id == ^id)
  end

  @doc false
  def changeset(album, attrs) do
    album
    |> cast(attrs, [:name])
    |> validate_required([:name])
  end
end
