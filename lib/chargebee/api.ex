defmodule Chargebee.API do
  defdelegate post(url, data), to: Chargebee.Config.api_impl
  defdelegate get(url, data), to: Chargebee.Config.api_impl
  defdelegate handle_response(resp),to: Chargebee.Config.api_impl
  defdelegate handle_list_response(resp), to: Chargebee.Config.api_impl
end
