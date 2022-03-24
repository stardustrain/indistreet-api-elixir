defmodule IndistreetApi.Music do
  @moduledoc """
  The Music context
  """

  import Ecto.Query
  alias IndistreetApi.Repo
  alias IndistreetApi.Music.Album
  alias IndistreetApi.Music.Song

  def list_albums(%{page: page, offset: offset} = %{page: page, offset: offset}) do
    albums = Repo.all(
               Album |> limit(^offset) |> offset(^((page - 1) * offset))
             )
             |> Repo.preload([:songs])
    count = Repo.aggregate(Album, :count)
    %{albums: albums, count: count}
  end

  def get_album!(id) do
    Album
    |> where([album], album.id == ^id)
    |> join(:left, [album], songs in assoc(album, :songs))
    |> preload([_, songs], [:songs])
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
end