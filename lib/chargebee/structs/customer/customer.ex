defmodule Chargebee.Customer do
  import Chargebee.API
  @derive [Poison.Encoder]
  @chargebee_url "/customers"

  defstruct [ :id,
              :first_name,
              :last_name,
              :email,
              :phone,
              :company,
              :vat_number,
              :auto_collection,
              :allow_direct_debit,
              :created_at,
              :created_from_ip,
              :taxability,
              :entity_code,
              :exempt_number,
              :card_status,
              :fraud_flag,
              :billing_address,
              :contacts,
              :payment_method,
              :invoice_notes,
              :promotional_credits,
              :refundable_credits,
              :excess_payments,
              :meta_data
            ]

    def create(customer) do
      post(@chargebee_url, customer) |> handle_response
    end

    def list(params \\ %{}) do
      get(@chargebee_url, params) |> handle_list_response
    end

    def retrieve(id) do
      get("#{@chargebee_url}/#{id}", %{}) |> handle_response
    end

    def update(customer) do
      post("#{@chargebee_url}/#{customer.id}", customer) |> handle_response
    end

    def delete(id, delete_payment_method \\ true) do
      post("#{@chargebee_url}/#{id}/delete", %{delete_payment_method: delete_payment_method}) |> handle_response
    end

    def update_payment_method_for_customer(customer_id, payment_method) do
      post("#{@chargebee_url}/#{customer_id}/update_payment_method", %{payment_method: payment_method}) |> handle_response
    end

    def update_billing_info_for_customer(customer_id, billing_address) do
      post("#{@chargebee_url}/#{customer_id}/update_billing_info", %{billing_address: billing_address}) |> handle_response
    end

    def add_contact_to_customer(customer_id, contact) do
      post("#{@chargebee_url}/#{customer_id}/add_contact", %{contact: contact}) |> handle_response
    end

    def udpate_contact_for_customer(customer_id, contact) do
      post("#{@chargebee_url}/#{customer_id}/update_contact", %{contact: contact}) |> handle_response
    end

    def delete_contact_for_customer(customer_id, contact) do
      post("#{@chargebee_url}/#{customer_id}/delete_contact", %{contact: contact}) |> handle_response
    end

    def add_promotional_credits_for_customer(customer_id, amount, currency_code, description) do
      post("#{@chargebee_url}/#{customer_id}/add_promotional_credits", %{amount: amount, currency_code: currency_code, description: description}) |> handle_response
    end

    def deduct_promotional_credits_for_customer(customer_id, amount, currency_code, description) do
      post("#{@chargebee_url}/#{customer_id}/deduct_promotional_credits", %{amount: amount, currency_code: currency_code, description: description}) |> handle_response
    end

    def set_promotional_credits_for_customer(customer_id, amount, currency_code, description) do
      post("#{@chargebee_url}/#{customer_id}/set_promotional_credits", %{amount: amount, currency_code: currency_code, description: description}) |> handle_response
    end

    def record_excess_payment_for_customer(customer_id, transaction, comment \\ "") do
      post("#{@chargebee_url}/#{customer_id}/record_excess_payment", %{transaction: transaction, comment: comment}) |> handle_response
    end
end
