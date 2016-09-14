defmodule Chargebee.PaymentMethod do
  @derive [Poison.Encoder]

  defstruct [ :type,
              :gateway,
              :status,
              :reference_id
            ]

end
