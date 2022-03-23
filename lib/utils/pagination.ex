defmodule Utils.Pagination do
  @moduledoc """
  Pagnination utils.
  """

  @default_option %{page: 1, offset: 10}

  @doc """
  Returns pagination option.

  - Examples

    iex> Utils.Pagination.get_pagination_option(%{})
    %{page: 1, offset: 10}
  """
  def get_pagination_option(option) do
    merge_option(option)
    |> Map.to_list
    |> Enum.reduce(%{}, fn ({key, val}, acc) -> Map.put_new(acc, key, parse_integer(val)) end)
  end

  defp merge_option(option) do
    Map.merge(@default_option, option, fn (_k, default, val) -> val || default end)
  end

  defp parse_integer(value) when is_binary(value) do
    String.to_integer(value, 10)
  end

  defp parse_integer(value) when is_integer(value) do
    value
  end
end
