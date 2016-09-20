defmodule Chargebee.API do
  import Chargebee.Utils

  defdelegate post(url, data), to: Chargebee.Config.api_impl
  defdelegate get(url, data), to: Chargebee.Config.api_impl

  def handle_response({:ok, %{body: json, status_code: 200}}) do
    output =
      Poison.decode!(json, keys: :atoms)
      |> Enum.map(fn {key,val} -> parse_body(key, val) end)
      |> Map.new

    {:ok, extract_single(output)}
  end

  def handle_response({_, non_200_response}) do
    {:error, Chargebee.Error.from_server_response(non_200_response)}
  end

  def handle_list_response({:ok, %{body: json, status_code: 200}}) do
    output = Poison.decode!(json, keys: :atoms)
    obj_list =
      Enum.map(output[:list], &(Enum.map(&1, fn {key,val} -> parse_body(key, val) end)))
      |> Enum.map(&(Map.new(&1)))
      |> Enum.map(&extract_single(&1))

    {:ok, (obj_list), output["next_offset"]}
  end

  def handle_list_response({_, non_200_response}) do
    {:error, Chargebee.Error.from_server_response(non_200_response)}
  end

  defp parse_body(key, value) when is_map(value) do
    parsed_map =
      Enum.map(safe_map(value), fn {key, value} -> parse_body(key, value) end)
      |> Map.new

    modul = map_key_to_module(key)

    if is_around?(modul) do
      {key, struct(map_key_to_module(key), parsed_map)}
    else
      {key, parsed_map}
    end
  end


  defp parse_body(key, value) when is_list(value) do
    if String.ends_with?(Atom.to_string(key), "_ids") do
      {key, value}
    else
      modul =
        Atom.to_string(key)
        |> String.trim_trailing("s")
        |> String.to_atom
        |> map_key_to_module

      if is_around?(modul) do
        {key, Enum.map(value, fn d -> struct(modul, d) end)}
      else
        {key, value}
      end
    end
  end

  defp parse_body(key, value), do: {key, value}

  defp extract_single(map) when map_size(map) == 1, do: Map.values(map) |> List.first
  defp extract_single(map), do: map
end
