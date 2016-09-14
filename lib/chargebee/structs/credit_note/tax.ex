defmodule Chargebee.Tax do
  @derive [Poison.Encoder]

  defstruct [ :name,
              :amount,
              :description
            ]
end
