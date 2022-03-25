defmodule IndistreetApi.V1.Music do
  @moduledoc false

  import Ecto.Query
  alias IndistreetApi.Repo
  alias IndistreetApi.Model.Music.Album

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
end
