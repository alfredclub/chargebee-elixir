defmodule Chargebee.Params do
  import Chargebee.Utils

  def encode_params(data) do
    safe_map(data)
    |> Enum.into([], fn {key,val} -> encode_key_value_pair(key,val) end)
    |> Enum.filter(&(&1))
    |> Enum.join("&")
  end

  defp encode_key_value_pair(_key, nil), do: nil

  defp encode_key_value_pair(key, value) when is_map(value) do
    safe_map(value)
    |> Enum.map(fn {inner_key, val} -> {"#{key}[#{inner_key}]",val} end)
    |> Map.new
    |> encode_params
  end

  defp encode_key_value_pair(key, value) when is_list(value) do
    value
    |> Enum.with_index
    |> Enum.map(fn {val, i} -> encode_list_value(val, i, key) end)
    |> List.flatten
    |> Map.new
    |> encode_params
  end

  defp encode_key_value_pair(key, value), do: "#{key}=#{value}"

  defp encode_list_value(value, index, key) when is_map(value) do
    value
    |> Enum.map(fn {inner_key, inner_value} -> {"#{key}[#{inner_key}][#{index}]",inner_value} end)
  end

  defp encode_list_value(value, index, key), do: {"#{key}[#{index}]",value}


end
