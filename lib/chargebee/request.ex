defmodule Chargebee.Request do
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

  def post(url, data) do
    post(url, encode_params(data), [])
  end

  def post(url, body, headers, options \\ []) do
    request(:post, url, body, headers, options_with_auth(options))
  end

  def get(url, data) when is_map(data), do: get(url, encode_params(data))
  def get(url, data) when is_binary(data), do: get("#{url}?#{data}", "", [])

  def get(url, body, headers, options \\ []) do
    request(:get, url, body, headers, options_with_auth(options))
  end

  defp options_with_auth(options) do
    Keyword.merge(options, [hackney: [basic_auth: {Chargebee.Config.api_key, ""}]])
  end


end
