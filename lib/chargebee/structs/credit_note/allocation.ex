defmodule Chargebee.Allocation do
  @derive [Poison.Encoder]

  defstruct [ :invoice_id,
              :allocated_amount,
              :allocated_at,
              :invoice_date,
              :invoice_status
            ]

end
