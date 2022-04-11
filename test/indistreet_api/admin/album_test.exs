defmodule IndistreetApi.Admin.AlbumTest do
  use IndistreetApi.DataCase

  alias IndistreetApi.Admin.Music

  describe "albums" do
    alias IndistreetApi.Model.Music.Album
    import IndistreetApi.AlbumFixture

    test "list_albums/1 returns all albums" do
      albums = multiple_album_fixtures()

      assert Music.list_albums(%{page: 1, offset: 10}) == %{albums: albums, count: 10}
      assert Music.list_albums(%{page: 1, offset: 5}) == %{albums: Enum.take(albums, 5), count: 10}
      assert Music.list_albums(%{page: 2, offset: 5}) == %{albums: Enum.take(albums, -5), count: 10}
      assert Music.list_albums(%{page: 3, offset: 10}) == %{albums: [], count: 10}
    end

    test "create_album/1 creates a album with valid data" do
      valid_attrs = %{name: "Test name", album_type: "SINGLE", description: "Test description"}

      assert {:ok, %Album{} = album} = Music.create_album(valid_attrs)
      assert album.name == "Test name"
      assert album.album_type == "SINGLE"
      assert album.description == "Test description"
    end

    test "create_album/1 creates a album with song data" do
      songs_attrs = [
        %{name: "Track 1"},
        %{name: "Track 2"},
      ]
      album_attrs = %{name: "Test name", album_type: "SINGLE", description: "Test description", songs: songs_attrs}

      assert {:ok, %Album{} = album} = Music.create_album(album_attrs)
      assert album.songs |> Enum.map(fn song -> %{name: song.name} end) === songs_attrs
    end

    test "create_album/1 return error with invalid data" do
      assert {:error, %Ecto.Changeset{}} = Music.create_album()
      assert {:error, %Ecto.Changeset{}} = Music.create_album(%{name: "Test name"})
      assert {:error, %Ecto.Changeset{}} = Music.create_album(%{name: 111, album_type: "SINGLE", description: ""})
      assert {:error, %Ecto.Changeset{}} = Music.create_album(%{name: 111, album_type: "Wrong album type"})
    end

    test "update_album/2 update a album with valid data" do
      created_album = album_fixture()
      update_attrs = %{name: "Update name", album_type: "EP", description: "Update description"}
      assert {:ok, %Album{} = album} = Music.update_album(created_album, update_attrs)
      assert album.name == "Update name"
      assert album.album_type == "EP"
      assert album.description == "Update description"
    end

    test "delete_album/1 delete a album when exist album" do
      album = album_fixture()

      assert {:ok, %Album{} = _album} = Music.delete_album(album)
    end
  end

end
