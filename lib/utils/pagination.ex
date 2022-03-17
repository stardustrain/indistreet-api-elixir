defmodule Utils.Pagination do
  @default_option %{page: 1, offset: 10}

  @moduledoc false
  def get_pagination_option(option) do
    merged_option = merge_option(option)
    Map.keys(merged_option)
      |> Enum.each(fn key -> Map.update!(merged_option, key, fn val -> parse_integer(val) end) end)

    merged_option
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
