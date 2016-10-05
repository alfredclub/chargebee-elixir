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

  def create(invoice, shipping_address \\ %{}, addons \\ [], charges \\ []) do
    params =
      invoice
      |> Map.take([:customer_id, :currency_code, :coupon, :po_number])
      |> Map.put(:shipping_address, shipping_address)
      |> Map.put(:addons, addons)
      |> Map.put(:charges, charges)

    post(@chargebee_url, params) |> handle_response
  end

  def create_for_charge(invoice, amount, description) do
    params =
      invoice
      |> Map.take([:customer_id, :subscription_id, :currency_code, :coupon, :po_number])
      |> Map.put(:amount, amount)
      |> Map.put(:description, description)

    post("#{@chargebee_url}/charge", params) |> handle_response
  end

  def create_for_addon(invoice, addon_id, addon_quantity) do
    params =
      invoice
      |> Map.take([:customer_id, :subscription_id, :coupon, :po_number])
      |> Map.put(:addon_id, addon_id)
      |> Map.put(:addon_quantity, addon_quantity)

    post("#{@chargebee_url}/charge_addon", params) |> handle_response
  end

  def stop_dunning(invoice_id) do
    post("#{@chargebee_url}/#{invoice_id}/stop_dunning", %{}) |> handle_response
  end

  def list(params \\ %{}) do
    get(@chargebee_url, params) |> handle_list_response
  end

  def retrieve(id) do
    get("#{@chargebee_url}/#{id}", %{}) |> handle_response
  end

  def retrieve_as_pdf(id) do
    post("#{@chargebee_url}/#{id}/pdf", %{}) |> handle_response
  end

  def add_charge(invoice_id, amount, description) do
    post("#{@chargebee_url}/#{invoice_id}/add_charge", %{amount: amount, description: description}) |> handle_response
  end

  def add_addon_to_pending_invoice(invoice_id, addon_id, addon_quantity \\ 1) do
    post("#{@chargebee_url}/#{invoice_id}/add_addon_charge", %{addon_id: addon_id, addon_quantity: addon_quantity}) |> handle_response
  end

  def close(invoice_id) do
    post("#{@chargebee_url}/#{invoice_id}/close", %{}) |> handle_response
  end

  def collect_payment(invoice_id, amount \\ nil) do
    post("#{@chargebee_url}/#{invoice_id}/collect_payment", %{amount: amount}) |> handle_response
  end

  def record_offline_payment(invoice_id, transaction, comment \\ nil) do
    params =
      %{}
      |> Map.put(:transaction, Map.take(transaction, [:amount, :payment_method, :reference_number, :date]))
      |> Map.put(:comment, comment)
    post("#{@chargebee_url}/#{invoice_id}/record_payment", params) |> handle_response
  end

  def refund(invoice_id, refund_amount \\ nil, comment \\ nil, customer_notes \\ nil, reason_code \\ nil) do
    params =
      %{}
      |> Map.put(:refund_amount, refund_amount)
      |> Map.put(:comment, comment)
      |> Map.put(:customer_notes, customer_notes)
      |> Map.put(:credit_note, %{reason_code: reason_code})
    post("#{@chargebee_url}/#{invoice_id}/refund", params) |> handle_response
  end

  def record_offline_refund(invoice_id, transaction, comment \\ nil, customer_notes \\ nil, reason_code \\ nil) do
      params =
        %{}
        |> Map.put(:transaction, Map.take(transaction, [:amount, :payment_method, :reference_number, :date]))
        |> Map.put(:comment, comment)
        |> Map.put(:customer_notes, customer_notes)
        |> Map.put(:credit_note, %{reason_code: reason_code})

    post("#{@chargebee_url}/#{invoice_id}/record_refund", params) |> handle_response
  end

  def void(invoice_id, comment \\ nil) do
    post("#{@chargebee_url}/#{invoice_id}/void", %{comment: comment}) |> handle_response
  end

  def write_off(invoice_id, comment \\ nil) do
    post("#{@chargebee_url}/#{invoice_id}/write_off", %{comment: comment}) |> handle_response
  end

  def delete(invoice_id, comment \\ nil) do
    post("#{@chargebee_url}/#{invoice_id}/delete", %{comment: comment}) |> handle_response
  end
end
