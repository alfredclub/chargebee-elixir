defmodule Chargebee.SubscriptionEstimate do
  @derive [Poison.Encoder]
  defstruct [ :id,
              :currency_code,
              :status,
              :next_billing_at,
              :shipping_address
            ]
end
