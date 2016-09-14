defmodule Chargebee.Coupon do
  import Chargebee.API
  @derive [Poison.Encoder]
  @chargebee_url "/coupons"

  defstruct [ :id,
              :name,
              :invoice_name,
              :discount_type,
              :discount_percentage,
              :discount_amount,
              :discount_quantity,
              :currency_code,
              :duration_type,
              :duration_month,
              :valid_till,
              :max_redemptions,
              :status,
              :apply_discount_on,
              :apply_on,
              :plan_constraint,
              :addon_constraint,
              :created_at,
              :archived_at,
              :plan_ids,
              :addon_ids,
              :redemptions,
              :invoice_notes,
              :meta_data
            ]
  def create(coupon) do
    post(@chargebee_url, coupon) |> handle_response
  end

  def update(coupon) do
    post("#{@chargebee_url}/#{coupon.id}", coupon) |> handle_response
  end

  def delete(id) do
    post("#{@chargebee_url}/#{id}/delete", %{}) |> handle_response
  end

  def retrieve(id) do
    get("#{@chargebee_url}/#{id}", %{}) |> handle_response
  end

  def list(params \\ %{}) do
    get(@chargebee_url, params) |> handle_list_response
  end
end
