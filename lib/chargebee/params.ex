defmodule Chargebee.Params do

  def encode_params(data = %{}) do
    Enum.into(safe_map(data), [], fn {key,val} -> encode_key_value_pair(key,val) end)
    |> Enum.filter(&(&1))
    |> Enum.join("&")
  end

  def safe_map(struct = %{__struct__: _}), do: Map.from_struct(struct)
  def safe_map(map = %{}), do: map

  defp encode_key_value_pair(_key, nil), do: nil
  defp encode_key_value_pair(key, value), do: "#{key}=#{value}"


end
