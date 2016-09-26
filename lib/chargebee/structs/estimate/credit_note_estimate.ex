defmodule Chargebee.CreditNoteEstimate do
  @derive [Poison.Encoder]

  defstruct [ :reference_invoice_id,
              :type,
              :price_type,
              :currency_code,
              :total,
              :amount_allocated,
              :amount_available,
              :sub_total,
              :line_items,
              :discounts,
              :taxes,
              :line_item_taxes
          ]
end
