defmodule PaginationTest do
  use ExUnit.Case
  doctest Utils.Pagination
  import Utils.Pagination

  setup_all do
    {:ok, default_option: %{page: 1, offset: 10}}
  end

  test "should return default option when receive empty option.", context do
    assert get_pagination_option(%{}) == context[:default_option]
  end

  test "should return merged option when receiving partial option.", context do
    assert get_pagination_option(%{page: 3}) == %{page: 3, offset: context[:default_option][:offset]}
    assert get_pagination_option(%{offset: 20}) == %{page: context[:default_option][:page], offset: 20}
  end

  test "should return received option when does not need default options." do
    assert get_pagination_option(%{page: 4, offset: 15}) == %{page: 4, offset: 15}
  end

  test "should return %{string, integer} map." do
    assert get_pagination_option(%{page: "1", offset: "10"}) == %{page: 1, offset: 10}
  end
end
