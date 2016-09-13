defmodule Chargebee.Plan do
  @derive [Poison.Encoder]

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
      Chargebee.Request.post('/plans', plan) |> handle_response
    end

    def update(plan) do
      Chargebee.Request.post("/plans/#{plan.id}", plan) |> handle_response
    end

    def delete(id) do
      Chargebee.Request.post("/plans/#{id}/delete", %{}) |> handle_response
    end

    def get(id) do
      Chargebee.Request.post("/plans/#{id}", %{}) |> handle_response
    end

    def list(params \\ %{}) do
      Chargebee.Request.get("/plans", params) |> handle_list_response
    end

    defp handle_response({:ok, %HTTPoison.Response{body: body, status_code: 200}}) do
      %{"plan" => plan} = Poison.decode!(body, as: %{"plan" => %__MODULE__{}})
      {:ok, plan}
    end

    defp handle_response({_, non_200_response}) do
      {:error, Chargebee.Error.from_server_response(non_200_response)}
    end

    defp handle_list_response({:ok, %HTTPoison.Response{body: body, status_code: 200}}) do
      %{"list" => lists} = Poison.decode!(body, as: %{"list" => [%{"plan" => %__MODULE__{}}]})
      json = Poison.Parser.parse!(body, keys: :atoms!)
      {:ok, Enum.map(lists, &(&1["plan"])), json[:next_offset]}
    end

    defp handle_list_response({_, non_200_response}) do
      {:error, Chargebee.Error.from_server_response(non_200_response)}
    end

end
