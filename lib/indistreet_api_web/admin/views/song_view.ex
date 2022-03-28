defmodule IndistreetApiWeb.Admin.SongView do
  @moduledoc false
  use IndistreetApiWeb, :view

  def render("show.json", %{song: song}) do
    album = %{album: render_one(song.album, __MODULE__, "album.json", as: :album)}
    Map.merge(song, album)
  end

  def render("album.json", %{album: album}) do
    %{
      id: album.id,
      name: album.name,
      description: album.description,
      inserted_at: album.inserted_at,
      updated_at: album.updated_at
    }
  end
end
