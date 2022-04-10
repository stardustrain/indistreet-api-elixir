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
    option
    |> Enum.filter(fn ({_k, v}) -> !is_nil(v) end)
    |> Enum.into(@default_option)
    |> Enum.reduce(%{}, fn ({key, val}, acc) -> Map.put_new(acc, key, parse_integer(val)) end)
  end

  defp parse_integer(value) when is_binary(value) do
    String.to_integer(value, 10)
  end

  defp parse_integer(value) when is_integer(value) do
    value
  end
end
