defmodule Chargebee.LinkedInvoice do
  @derive [Poison.Encoder]

  defstruct [ :invoice_id,
              :applied_amount,
              :applied_at,
              :invoice_date,
              :invoice_total,
              :invoice_status
            ]

end
