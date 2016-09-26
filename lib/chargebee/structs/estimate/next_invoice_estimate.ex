defmodule Chargebee.NextInvoiceEstimate do
  @derive [Poison.Encoder]
  defstruct Map.to_list(Map.from_struct(Chargebee.InvoiceEstimate))
end
