defmodule IndistreetApi.Schema do
  @moduledoc false
  defmacro __using__(_opts) do
    quote do
      use Ecto.Schema
      import Ecto.Changeset
      import Ecto.Query, warn: false
      alias IndistreetApi.Repo

      @timestamps_opts [type: :utc_datetime]
    end
  end
end
