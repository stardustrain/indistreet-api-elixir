defmodule IndistreetApi.Music do
  @moduledoc """
  The Music context
  """

  import Ecto.Query
  alias IndistreetApi.Repo
  alias IndistreetApi.Music.Album

  def list_albums(%{page: page, offset: offset} = %{page: page, offset: offset}) do
    Repo.all(Album |> limit(^offset) |> offset(^((page - 1) * offset)))
  end

  def get_product!(id) do
    Repo.one!(from album in Album, where: album.id == ^id)
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
end