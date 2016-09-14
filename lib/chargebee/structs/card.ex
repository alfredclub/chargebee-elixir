defmodule Chargebee.Card do
  import Chargebee.API
  @derive [Poison.Encoder]
  @chargebee_url "/cards"

  defstruct [ :customer_id,
              :status,
              :gateway,
              :first_name,
              :last_name,
              :iin,
              :last4,
              :card_type,
              :expiry_month,
              :expiry_year,
              :billing_addr1,
              :billing_addr2,
              :billing_city,
              :billing_state_code,
              :billing_state,
              :billing_country,
              :billing_zip,
              :ip_address,
              :masked_number
            ]
            
  def retrieve(customer_id) do
    get("#{@chargebee_url}/#{customer_id}", %{}) |> handle_response
  end

  def update_card_for_customer(card) do
    post("/customers/#{card.customer_id}/credit_card", card) |> handle_response
  end

  def switch_gateway_for_customer(customer_id, gateway) do
    post("/customers/#{customer_id}/switch_gateway", %{gateway: gateway}) |> handle_response
  end

  def copy_card_for_customer(customer_id, gateway) do
    post("/customers/#{customer_id}/copy_card", %{gateway: gateway}) |> handle_response
  end

  def delete_card_for_customer(customer_id) do
    post("/customers/#{customer_id}/delete_card", %{}) |> handle_response
  end

end
