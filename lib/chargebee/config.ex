defmodule Chargebee.Config do
  def site do
    Application.get_env(:chargebee, :site, System.get_env("CHARGEBEE_SITE")) |> check_value
  end

  def api_key do
    Application.get_env(:chargebee, :api_key, System.get_env("CHARGEBEE_API_KEY")) |> check_value
  end

  defp check_value(nil) do
    raise ArgumentError, message: "Invalid config value given"
  end

  defp check_value(value), do: value

end
