defmodule Chargebee.Address do
  import Chargebee.API
  @derive [Poison.Encoder]
  @chargebee_url "/addresses"

  defstruct [ :subscription_id,
              :label,
              :first_name,
              :last_name,
              :email,
              :company,
              :phone,
              :addr,
              :extended_addr,
              :extended_addr2,
              :city,
              :state_code,
              :state,
              :country,
              :zip,
              :validation_status
            ]

  def update(address) do
    post(@chargebee_url, address) |> handle_response
  end

  def retrieve(subscription_id, label) do
    get(@chargebee_url, %{subscription_id: subscription_id, label: label}) |> handle_response
  end
end
