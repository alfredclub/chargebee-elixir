defmodule Chargebee.Error do
  defstruct status_code: nil,
            message: "An error occurred",
            reason: nil,
            meta_data: %{}

  def from_server_response(%{body: body, status_code: status_code}) do
    map_body = Poison.decode!(body)
    from_error_body(map_body, status_code)
  end

  def from_server_response(%{reason: reason} = error) do
    struct(__MODULE__, %{reason: reason,
                         meta_data: error})
  end

  defp from_error_body(body = %{"message" => message}, status_code) do
    struct(__MODULE__, %{message: message,
                         status_code: status_code,
                         meta_data: body})
  end

  defp from_error_body(body, status_code) do
    struct(__MODULE__, %{status_code: status_code,
                         meta_data: body})
  end
  
end
