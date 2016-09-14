defmodule ParamsTest do
  use ExUnit.Case
  doctest Chargebee.Params

  alias Chargebee.Params

  test "params parse list of vals" do
    params = %{listis: [1, 2]}

    assert Params.encode_params(params) == "listis[0]=1&listis[1]=2"
  end

  test "params parse list of maps" do
    params = %{listis: [ %{ one: 1, two: 2}, %{ one: 3}]}

    assert Params.encode_params(params) == "listis[one][0]=1&listis[one][1]=3&listis[two][0]=2"
  end
end
