defmodule Chargebee.CreditNote do
  import Chargebee.API
  @derive [Poison.Encoder]
  @chargebee_url "/credit_notes"

  defstruct [ :id,
              :customer_id,
              :subscription_id,
              :reference_invoice_id,
              :type,
              :reason_code,
              :status,
              :vat_number,
              :date,
              :price_type,
              :currency_code,
              :total,
              :amount_allocated,
              :amount_refunded,
              :amount_available,
              :refunded_at,
              :sub_total,
              :line_items,
              :discounts,
              :taxes,
              :line_item_taxes,
              :linked_refunds,
              :allocations
            ]

  def create(credit_note) do
    post(@chargebee_url, credit_note) |> handle_response
  end

  def list(params \\ %{}) do
    get(@chargebee_url, params) |> handle_list_response
  end

  def retrieve(id) do
    get("#{@chargebee_url}/#{id}", %{}) |> handle_response
  end

  def retrieve_as_pdf(id) do
    get("#{@chargebee_url}/#{id}/pdf", %{}) |> handle_response
  end

end
