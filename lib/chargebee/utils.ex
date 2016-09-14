defmodule Chargebee.Utils do

  def safe_map(struct = %{__struct__: _}), do: Map.from_struct(struct)
  def safe_map(map) when is_map(map), do: map

  def map_key_to_module(key) do
    "Elixir.Chargebee." <> Macro.camelize(Atom.to_string(key))
    |> String.to_atom
  end

  def is_around?(modul), do: Code.ensure_compiled? modul

end
