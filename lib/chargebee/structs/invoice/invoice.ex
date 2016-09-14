defmodule Chargebee.Invoice do
  import Chargebee.API
  @derive [Poison.Encoder]
  @chargebee_url "/invoices"

  defstruct [ :id,
              :po_number,
              :customer_id,
              :coupon,
              :subscription_id,
              :recurring,
              :status,
              :vat_number,
              :price_type,
              :date,
              :currency_code,
              :total,
              :amount_paid,
              :amount_adjusted,
              :write_off_amount,
              :credits_applied,
              :amount_due,
              :paid_at,
              :dunning_status,
              :next_retry_at,
              :sub_total,
              :tax,
              :first_invoice,
              :line_items,
              :discounts,
              :taxes,
              :line_item_taxes,
              :linked_payments,
              :applied_credits,
              :adjustment_credit_notes,
              :issued_credit_notes,
              :linked_orders,
              :notes,
              :shipping_address,
              :billing_address
          ]

  #TODO implement API
  

end
