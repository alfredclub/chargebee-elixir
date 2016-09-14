defmodule Chargebee.Contact do
  @derive [Poison.Encoder]

  defstruct [ :id,
              :first_name,
              :last_name,
              :email,
              :phone,
              :label,
              :enabled,
              :send_account_email,
              :send_billing_email
            ]
end
