defmodule Chargebee.Estimate do
  import Chargebee.API
  @derive [Poison.Encoder]
  @chargebee_url "/estimates"

  defstruct [
    :object,
    :subscription_estimate,
    :next_invoice_estimate
  ]

  def create_subscription_estimate(subscription) do

  end

end
