defmodule IndistreetApi.Music.Album do
  @moduledoc false

  use IndistreetApi.Schema
  alias IndistreetApi.Music.Song

  @album_types ["SINGLE", "EP", "MINI_ALBUM", "FULL_ALBUM", "OST"]

  @derive {Jason.Encoder, except: [:__meta__]}
  schema "albums" do
    field :name, :string
    field :album_type, :string
    field :description, :string
    has_many :songs, Song

    timestamps()
  end

  @doc false
  def changeset(album, attrs) do
    album
    |> Repo.preload(:songs)
    |> cast(attrs, [:name, :album_type, :description])
    |> cast_assoc(:songs)
    |> validate_required([:name, :album_type])
    |> validate_inclusion(:album_type, @album_types)
  end
end
