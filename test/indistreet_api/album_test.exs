defmodule IndistreetApi.AlbumTest do
  use IndistreetApi.DataCase
  
  alias IndistreetApi.Music

  describe "albums" do
    alias IndistreetApi.Music.Album
    import IndistreetApi.AlbumFixture

    test "list_albums/1 returns all albums" do
      albums = multiple_album_fixtures()

      assert Music.list_albums(%{page: 1, offset: 10}) == albums
      assert Music.list_albums(%{page: 1, offset: 5}) == Enum.take(albums, 5)
      assert Music.list_albums(%{page: 2, offset: 5}) == Enum.take(albums, -5)
      assert Music.list_albums(%{page: 3, offset: 10}) == []
    end

    test "create_album/1 creates a album with valid data" do
      valid_attrs = %{name: "Test name", album_type: "SINGLE", description: "Test description"}

      assert {:ok, %Album{} = album} = Music.create_album(valid_attrs)
      assert album.name == "Test name"
      assert album.album_type == "SINGLE"
      assert album.description == "Test description"
    end

    test "create_album/1 throw error with invalid data" do
      assert {:error, %Ecto.Changeset{}} = Music.create_album()
      assert {:error, %Ecto.Changeset{}} = Music.create_album(%{name: "Test name"})
      assert {:error, %Ecto.Changeset{}} = Music.create_album(%{name: 111, album_type: "SINGLE", description: ""})
      assert {:error, %Ecto.Changeset{}} = Music.create_album(%{name: 111, album_type: "Wrong album type"})
    end
  end

end
