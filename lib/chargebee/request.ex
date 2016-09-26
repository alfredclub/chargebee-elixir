defmodule Chargebee.Request do
  import Chargebee.Utils
  import Chargebee.Params, only: [encode_params: 1]
  use HTTPoison.Base

  @api_version "v2"

  def process_url(url) do
    "https://#{Chargebee.Config.site}.chargebee.com/api/#{@api_version}" <> url
  end

  def process_request_headers(headers) do
    Dict.put(headers, :"Content-Type", "application/x-www-form-urlencoded; charset=utf-8")
    |> Dict.put(:"accept", "application/json")
  end

  def post(url, data), do: post(url, encode_params(data), [])
  def post(url, body, headers, options \\ []) do
    request(:post, url, body, headers, options_with_auth(options))
  end

  def get(url, data) when is_map(data), do: get(url, encode_params(data))
  def get(url, data) when is_binary(data), do: get("#{url}?#{data}", "", [])
  def get(url, body, headers, options \\ []) do
    request(:get, url, body, headers, options_with_auth(options))
  end

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

  defp extract_single(map) when map_size(map) == 1, do: Map.values(map) |> List.first
  defp extract_single(map), do: map

  defp parse_body(key, value) when is_map(value) do
    parsed_map =
      safe_map(value)
      |> Enum.map(fn {key, value} -> parse_body(key, value) end)
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

  defp options_with_auth(options) do
    Keyword.merge(options, [hackney: [basic_auth: {Chargebee.Config.api_key, ""}]])
  end
end
