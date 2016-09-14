defmodule Chargebee.LinkedCreditNote do
  @derive [Poison.Encoder]

  defstruct [ :cn_id,
              :applied_amount,
              :applied_at,
              :cn_reason_code,
              :cn_date,
              :cn_total,
              :cn_status,
              :cn_reference_invoice_id]

end
