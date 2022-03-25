defmodule IndistreetApi.Model.Music.Song do
  @moduledoc """

  """

  use IndistreetApi.Schema
  alias IndistreetApi.Model.Music.Album

  @derive {Jason.Encoder, except: [:__meta__]}
  schema "songs" do
    field :name, :string
    belongs_to :album, Album

    timestamps()
  end

  @doc false
  def changeset(song, attrs) do
    song
    |> cast(attrs, [:name])
    |> validate_required([:name])
  end
end
