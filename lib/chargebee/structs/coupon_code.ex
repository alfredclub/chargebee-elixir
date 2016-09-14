defmodule Chargebee.CouponCode do
  import Chargebee.API
  @derive [Poison.Encoder]
  @chargebee_url "/coupon_codes"

  defstruct [ :code,
              :status,
              :coupon_id,
              :coupon_set_name
            ]

  def create(coupon_code) do
    post(@chargebee_url, coupon_code) |> handle_response
  end

  def retrieve(coupon_code_code) do
    get("#{@chargebee_url}/#{coupon_code_code}", %{}) |> handle_response
  end

  def archive(coupon_code_code) do
    post("#{@chargebee_url}/#{coupon_code_code}/archive", %{}) |> handle_response
  end

end
