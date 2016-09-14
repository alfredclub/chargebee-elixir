defmodule Chargebee.LinkedRefund do
  @derive [Poison.Encoder]

  defstruct [ :txn_id,
              :txn_status,
              :txn_date,
              :txn_amount
            ]

end
