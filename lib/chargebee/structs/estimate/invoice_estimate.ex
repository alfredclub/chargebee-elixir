defmodule Chargebee.InvoiceEstimate do
  @derive [Poison.Encoder]

  defstruct [ :recurring,
              :price_type,
              :currency_code,
              :total,
              :amount_paid,
              :credits_applied,
              :amount_due,
              :sub_total,
              :line_items,
              :discounts,
              :taxes,
              :line_item_taxes
          ]
end
