defmodule Chargebee.LineItemTax do
  @derive [Poison.Encoder]

  defstruct [ :line_item_id,
              :tax_name,
              :tax_rate,
              :tax_amount,
              :tax_juris_type,
              :tax_juris_name,
              :tax_juris_code
            ]

end
