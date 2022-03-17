defmodule IndistreetApi.Music.Album do
  use Ecto.Schema
  import Ecto.Changeset
  import Ecto.Query, warn: false

  schema "albums" do
    field :name, :string
    field :album_type, :string
    field :description, :string

    timestamps()
  end

  @doc false
  def changeset(album, attrs) do
    album
    |> cast(attrs, [:name])
    |> validate_required([:name])
  end
end
