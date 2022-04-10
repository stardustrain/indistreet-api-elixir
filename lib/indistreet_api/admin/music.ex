defmodule IndistreetApi.Admin.Music do
  @moduledoc """
  The Music context
  """

  import Ecto.Query
  alias IndistreetApi.Repo
  alias IndistreetApi.Model.Music.Album
  alias IndistreetApi.Model.Music.Song

  def list_albums(%{page: page, offset: offset} = %{page: page, offset: offset}) do
    albums = Album
             |> limit(^offset)
             |> offset(^((page - 1) * offset))
             |> preload([:songs])
             |> Repo.all
    count = Repo.aggregate(Album, :count)
    %{albums: albums, count: count}
  end

  def get_album!(id) do
    Album
    |> where([album], album.id == ^id)
    |> join(:left, [album], songs in assoc(album, :songs))
    |> preload([:songs])
    |> Repo.one!
  end

  def create_album(attrs \\ %{}) do
    %Album{}
    |> Album.changeset(attrs)
    |> Repo.insert()
  end

  def update_album(%Album{} = album, attrs \\ %{}) do
    album
    |> Album.changeset(attrs)
    |> Repo.update()
  end

  def delete_album(%Album{} = album) do
    Repo.delete(album)
  end

  def create_song(attrs \\ %{}) do
    album = get_album!(attrs.album_id)

    %Song{}
    |> Song.changeset(attrs)
    |> Ecto.Changeset.put_assoc(:album, album)
    |> Repo.insert()
  end

  def list_song(attrs) do
    offset = attrs.offset
    page = attrs.page
    album_id = Map.get(attrs, :album_id)

    songs_query = Song
            |> limit(^offset)
            |> offset(^((page - 1) * offset))
            |> preload([:album])

    songs_query = cond do
      is_nil(album_id) -> songs_query
      true -> songs_query |> where(album_id: ^album_id)
    end

    songs = Repo.all(songs_query)
    count = Repo.aggregate(Song, :count)

    %{songs: songs, count: count}
  end

  def get_song!(id) do
    Song
    |> where([song], song.id == ^id)
    |> join(:left, [song], album in assoc(song, :album))
    |> preload([:album])
    |> Repo.one!
  end
end
