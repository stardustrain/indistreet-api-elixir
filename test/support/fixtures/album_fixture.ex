defmodule IndistreetApi.AlbumFixture do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `IndistreetApi.Music` context.
  """

  @doc """
  Generate a one of album
  """
  def album_fixture(attrs \\ %{}) do
    {:ok, album} =
      attrs
      |> Enum.into(%{
        name: "Test album name",
        album_type: "SINGLE",
        description: "Test album description"
      })
      |> IndistreetApi.Music.create_album()

    album
  end

  def multiple_album_fixtures(count \\ 10) do
    for _x <- 1..count do
      album_fixture()
    end
  end
end