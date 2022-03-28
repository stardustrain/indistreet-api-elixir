defmodule IndistreetApiWeb.Admin.AlbumView do
  use IndistreetApiWeb, :view

  def render("index.json", %{albums_data: %{albums: albums, count: count}}) do
    %{albums: render_many(albums, __MODULE__, "show.json", as: :album), count: count}
  end

  def render("show.json", %{album: album}) do
    songs = %{songs: render_many(album.songs, __MODULE__, "song.json", as: :song)}
    Map.merge(album, songs)
  end

  def render("song.json", %{song: song}) do
    %{
      id: song.id,
      name: song.name,
      inserted_at: song.inserted_at,
      updated_at: song.updated_at
    }
  end
end
