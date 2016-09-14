defmodule Chargebee.Discount do
  @derive [Poison.Encoder]

  defstruct [ :amount,
              :description,
              :entity_type,
              :entity_id
            ]
end
