defmodule IndistreetApi.SongFixture do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `IndistreetApi.Music` context.
  """

  alias IndistreetApi.AlbumFixture

  @doc """
  Generate a one of song with album.
  """
  def song_fixture(attrs \\ %{}) do
    album = AlbumFixture.album_fixture()

    {:ok, song} =
      attrs
      |> Enum.into(%{
        name: "Test song",
        album_id: album.id
      })
      |> IndistreetApi.Admin.Music.create_song

    song
  end

  @doc """
  Generate a multiple song with album.
  """
  def multiple_song_fixture(count \\ 10) do
    first_album = AlbumFixture.album_fixture()
    second_album = AlbumFixture.album_fixture()

    {:ok, songs} = Enum.map_every(1..count, 1, fn x -> %{name: "Song no.#{x}"} end)
            |> Enum.with_index
            |> Enum.reduce(Ecto.Multi.new(), fn ({attrs, index}, multi) ->
              album_id = if rem(index, 2) === 0, do: first_album.id, else: second_album.id
              changeset = %IndistreetApi.Music.Song{album_id: album_id}
              |> IndistreetApi.Music.Song.changeset(attrs)

              Ecto.Multi.insert(multi, {:song, index}, changeset)
            end)
            |> IndistreetApi.Repo.transaction

    Map.values(songs)
  end
end
