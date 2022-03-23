defmodule IndistreetApiWeb.Admin.AlbumView do
  use IndistreetApiWeb, :view

  def render("index.json", %{albums_data: %{albums: albums, count: count}}) do
    %{data: %{albums: albums, count: count}}
  end

  def render("show.json", %{album: album}) do
    %{data: album}
  end
end