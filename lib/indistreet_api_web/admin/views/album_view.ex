defmodule IndistreetApiWeb.Admin.AlbumView do
  use IndistreetApiWeb, :view

  def render("show.json", %{album: album}) do
    %{data: album}
  end
end
