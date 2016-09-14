defmodule Chargebee.Webhook do
  @derive [Poison.Encoder]
  defstruct [ :id, :webhook_status ]
end

defmodule Chargebee.Event do
  import Chargebee.API
  @derive [Poison.Encoder]
  @chargebee_url "/events"

  defstruct [ :id,
              :occurred_at,
              :source,
              :user,
              :webhook_status,
              :webhook_failure_reason,
              :webhooks,
              :event_type,
              :api_version,
              :content
            ]

  def retrieve(id) do
    get("#{@chargebee_url}/#{id}", %{}) |> handle_response
  end

  def list(params \\ %{}) do
    get(@chargebee_url, params) |> handle_list_response
  end

  def from_webhook(json) do
    handle_response({:ok, %{body: json, status_code: 200}})
  end

end
