defmodule IndistreetApi.Admin.SongTest do
  use IndistreetApi.DataCase

  alias IndistreetApi.Admin.Music

  describe "songs" do
    alias IndistreetApi.Model.Music.Song

    import IndistreetApi.AlbumFixture
    import IndistreetApi.SongFixture

    test "create_song/1 creates a album with valid data" do
      album_fixture()
      valid_attrs = %{name: "Test song", album_id: 1}

      {:ok, %Song{} = song} = Music.create_song(valid_attrs)
      assert song.name === "Test song"
      assert song.album_id === 1
    end

    test "list_songs/1 returns all songs." do
      multiple_song_fixture()

      assert Music.list_song(%{page: 1, offset: 10}).songs |> length === 10
      assert Music.list_song(%{page: 1, offset: 10, album_id: 1}).songs |> length === 5
      assert Music.list_song(%{page: 2, offset: 10}) === %{songs: [], count: 10}
    end

    test "get_song!/1 return song with id" do
      song = song_fixture()

      assert Music.get_song!(1).id === song.id
      assert Music.get_song!(1).name === song.name
      assert Music.get_song!(1).album.id === song.album.id
    end
  end

end
