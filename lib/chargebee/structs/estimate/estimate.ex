defmodule Chargebee.Estimate do
  import Chargebee.API
  @derive [Poison.Encoder]
  @chargebee_url "/estimates"

  defstruct [ :created_at,
              :subscription_estimate,
              :invoice_estimate,
              :next_invoice_estimate,
              :credit_note_estimates
            ]

  def create_subscription(subscription, billing_address \\ %{}, shipping_address \\ %{}, customer \\ %{}, addons \\ []) do
    params =
      Map.new
      |> Map.put(:subscription, subscription)
      |> Map.put(:billing_address, billing_address)
      |> Map.put(:shipping_address, shipping_address)
      |> Map.put(:customer, customer)
      |> Map.put(:addons, addons)

    post("#{@chargebee_url}/create_subscription", params) |> handle_response
  end

  def update_subscription(subscription, billing_address \\ %{}, shipping_address \\ %{}, customer \\ %{}, addons \\ [], other_params \\ %{}) do
    params =
      other_params
      |> Map.put(:subscription, subscription)
      |> Map.put(:billing_address, billing_address)
      |> Map.put(:shipping_address, shipping_address)
      |> Map.put(:customer, customer)
      |> Map.put(:addons, addons)

    post("#{@chargebee_url}/update_subscription", params) |> handle_response
  end

  def renewal_estimate(subscription_id, params \\ %{}) do
    get("/subscriptions/#{subscription_id}/renewal_estimate", params) |> handle_response
  end

end
