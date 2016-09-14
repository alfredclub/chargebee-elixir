defmodule Chargebee.Plan do
  import Chargebee.API
  @derive [Poison.Encoder]
  @chargebee_url "/plans"

  defstruct [ :id,
              :name,
              :invoice_name,
              :price,
              :currency_code,
              :period,
              :period_unit,
              :trial_period,
              :trial_period_unit,
              :charge_model,
              :free_quantity,
              :setup_cost,
              :downgrade_penalty,
              :status,
              :achieved_at,
              :billing_cycles,
              :redirect_url,
              :enabled_in_hosted_pages,
              :enabled_in_portal,
              :tax_code,
              :invoice_notes,
              :taxable,
              :meta_data
            ]

  def create(plan) do
    post(@chargebee_url, plan) |> handle_response
  end

  def update(plan) do
    post("#{@chargebee_url}/#{plan.id}", plan) |> handle_response
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
