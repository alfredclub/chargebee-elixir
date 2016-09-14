defmodule Chargebee.API do
  defdelegate post(url, data), to: Application.get_env(:chargebee, :api_impl)
  defdelegate get(url, data), to: Application.get_env(:chargebee, :api_impl)

  def handle_response({:ok, %{body: json, status_code: 200}}) do
    output =
      Poison.decode!(json, keys: :atoms)
      |> Enum.map(fn {key,val} -> parse_body(key, val) end)

    case length(output) do
      1 -> {:ok, List.first(output)}
      _ -> {:ok, output}
    end
  end

  def handle_response({_, non_200_response}) do
    {:error, Chargebee.Error.from_server_response(non_200_response)}
  end

  def handle_list_response({:ok, %{body: json, status_code: 200}}) do
    output = Poison.decode!(json, keys: :atoms)
    obj_list = Enum.map(output[:list], &(Enum.map(&1, fn {key,val} -> parse_body(key, val) end)))

    {:ok, List.flatten(obj_list), output["next_offset"]}
  end

  def handle_list_response({_, non_200_response}) do
    {:error, Chargebee.Error.from_server_response(non_200_response)}
  end

  defp parse_body(key, val) when is_map(val) do
    "Elixir.Chargebee." <> String.capitalize(Atom.to_string(key))
    |> String.to_atom
    |> struct(val)
  end

end
