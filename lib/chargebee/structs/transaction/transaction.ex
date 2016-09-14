defmodule Chargebee.Transaction do
  import Chargebee.API
  @derive [Poison.Encoder]
  @chargebee_url "/transactions"

  defstruct [ :id,
              :customer_id,
              :subscription_id,
              :payment_method,
              :reference_number,
              :gateway,
              :type,
              :date,
              :currency_code,
              :amount,
              :id_at_gateway,
              :status,
              :error_code,
              :error_text,
              :voided_at,
              :amount_unused,
              :masked_card_number,
              :reference_transaction_id,
              :refunded_txn_id,
              :reversal_transaction_id,
              :linked_invoices,
              :linked_credit_notes,
              :linked_refunds
            ]

  def list(params \\ %{}) do
    get(@chargebee_url, params) |> handle_list_response
  end
  
  def retrieve(id) do
    get("#{@chargebee_url}/#{id}", %{}) |> handle_response
  end

  def list_payments_for_invoice(invoice_id, params \\ %{}) do
    get("/invoices/#{invoice_id}/payments", params) |> handle_list_response
  end

end
