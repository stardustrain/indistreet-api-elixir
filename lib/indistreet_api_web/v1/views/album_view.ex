defmodule IndistreetApiWeb.V1.AlbumView do
  use IndistreetApiWeb, :view

  def render("index.json", %{albums: albums}) do
    %{data: albums}
  end

  def render("show.json", %{album: album}) do
    %{data: album}
  end
end
