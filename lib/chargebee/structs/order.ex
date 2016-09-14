defmodule Chargeebee.Order do
  import Chargebee.API
  @derive [Poison.Encoder]
  @chargebee_url "/orders"

  defstruct [ :id,
              :invoice_id,
              :status,
              :reference_id,
              :fulfillment_status,
              :note,
              :tracking_id,
              :batch_id,
              :created_by,
              :created_at,
              :status_update_at
            ]

  def create(order) do
    post(@chargebee_url, order) |> handle_response
  end

  def update(order) do
    post("#{@chargebee_url}/#{order.id}", order) |> handle_response
  end

  def delete(id) do
    post("#{@chargebee_url}/#{id}/delete", %{}) |> handle_response
  end

  def retrieve(id) do
    get("#{@chargebee_url}/#{id}", %{}) |> handle_response
  end

  def list(params \\ %{}) do
    get(@chargebee_url, params) |> handle_list_response
  end
end
