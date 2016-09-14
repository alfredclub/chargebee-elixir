defmodule Chargebee.Address do
  import Chargebee.API
  @derive [Poison.Encoder]
  @chargebee_url "/addresses"

  defstruct [ :id,
              :name,
              :invoice_name,
              :description,
              :type,
              :charge_type,
              :price,
              :currency_code,
              :period,
              :period_unit,
              :unit,
              :status,
              :archived_at,
              :enabled_in_portal,
              :tax_code,
              :invoice_notes,
              :taxable,
              :meta_data
            ]

  def update(address) do
    post(@chargebee_url, address) |> handle_response
  end

  def retrieve(subscription_id, label) do
    get(@chargebee_url, %{subscription_id: subscription_id, label: label}) |> handle_response
  end
end
