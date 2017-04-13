defmodule Chargebee.Subscription do
  import Chargebee.API
  @derive [Poison.Encoder]
  @chargebee_url "/subscriptions"

  defstruct [ :id,
              :customer_id,
              :currency_code,
              :plan_id,
              :plan_quantity,
              :status,
              :start_date,
              :trial_start,
              :trial_end,
              :current_term_start,
              :current_term_end,
              :billing_cycle,
              :remaining_billing_cycles,
              :po_number,
              :created_at,
              :started_at,
              :activated_at,
              :cancelled_at,
              :cancel_reason,
              :affiliate_token,
              :created_from_ip,
              :has_scheduled_changes,
              :due_invoices_count,
              :due_since,
              :total_dues,
              :addons,
              :coupon,
              :coupons,
              :coupon_ids,
              :billing_address,
              :shipping_address,
              :invoice_notes,
              :meta_data,
              :replace_addon_list,
              :replace_coupon_list
            ]

    def create(subscription, customer \\ %{}, card \\ %{}, payment_method \\ %{}) do
      params =
        Map.from_struct(subscription)
        |> Map.put(:customer, customer)
        |> Map.put(:card, card)
        |> Map.put(:payment_method, payment_method)

      post(@chargebee_url, params) |> handle_response
    end

    def create_for_customer(customer_id, subscription) do
      post("/customers/#{customer_id}/subscriptions", subscription) |> handle_response
    end

    def list(params \\ %{}) do
      get(@chargebee_url, params) |> handle_list_response
    end

    def list_for_customer(customer_id, params \\ %{}) do
      get("/customers/#{customer_id}/subscriptions", params) |> handle_list_response
    end

    def update(subscription, customer \\ %{}, card \\ %{}, payment_method \\ %{}) do
      params =
        Map.from_struct(subscription)
        |> Map.put(:customer, customer)
        |> Map.put(:card, card)
        |> Map.put(:payment_method, payment_method)
      post("#{@chargebee_url}/#{subscription.id}", params) |> handle_response
    end

    def retrieve(id) do
      get("#{@chargebee_url}/#{id}", %{}) |> handle_response
    end

    def retrieve_with_scheduled_changes(id) do
      get("#{@chargebee_url}/#{id}/retrieve_with_scheduled_changes", %{}) |> handle_response
    end

    def remove_scheduled_changes(id) do
      post("#{@chargebee_url}/#{id}/remove_scheduled_changes", %{}) |> handle_response
    end

    def remove_scheduled_cancellation(id, billing_cycles \\ nil) do
      post("#{@chargebee_url}/#{id}/remove_scheduled_cancellation", %{billing_cycles: billing_cycles}) |> handle_response
    end

    def remove_coupons(id, coupon_ids) do
      post("#{@chargebee_url}/#{id}/remove_coupons", %{coupon_ids: coupon_ids}) |> handle_response
    end

    def change_term_end(id, term_ends_at) do
      post("#{@chargebee_url}/#{id}/change_term_end", %{term_ends_at: term_ends_at}) |> handle_response
    end

    def cancel(id, end_of_term \\ nil) do
      post("#{@chargebee_url}/#{id}/cancel", %{end_of_term: end_of_term}) |> handle_response
    end

    def reactivate(id, params \\ %{}) do
      post("#{@chargebee_url}/#{id}/reactivate", params) |> handle_response
    end

    def add_charge_at_term_end(id, amount, description) do
      post("#{@chargebee_url}/#{id}/add_charge_at_term_end", %{amount: amount, description: description}) |> handle_response
    end

    def charge_addon_at_term_end(id, addon_id, addon_quantity \\ nil) do
      post("#{@chargebee_url}/#{id}/add_charge_at_term_end", %{addon_id: addon_id, addon_quantity: addon_quantity}) |> handle_response
    end

    def delete(id) do
      post("#{@chargebee_url}/#{id}/delete", %{}) |> handle_response
    end
end
