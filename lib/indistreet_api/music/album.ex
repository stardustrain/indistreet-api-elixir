defmodule IndistreetApi.Music.Album do
  @moduledoc false

  use Ecto.Schema
  import Ecto.Changeset
  import Ecto.Query, warn: false

  @album_types ["SINGLE", "EP", "MINI_ALBUM", "FULL_ALBUM", "OST"]
  @timestamps_opts [type: :utc_datetime]

  @derive {Jason.Encoder, except: [:__meta__]}
  schema "albums" do
    field :name, :string
    field :album_type, :string
    field :description, :string
    timestamps()
  end

  @doc false
  def changeset(album, attrs) do
    album
    |> cast(attrs, [:name, :album_type, :description])
    |> validate_required([:name, :album_type])
    |> validate_inclusion(:album_type, @album_types)
  end
end
