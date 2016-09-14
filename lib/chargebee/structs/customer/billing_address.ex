defmodule Chargebee.BillingAddress do
  @derive [Poison.Encoder]

  defstruct [ :first_name,
              :last_name,
              :email,
              :company,
              :phone,
              :line1,
              :line2,
              :line3,
              :city,
              :state_code,
              :state,
              :country,
              :zip,
              :validation_status
           ]

end
