defmodule PlayChannelWeb.ToyChannel do
  use PlayChannelWeb, :channel

  def join("toys:" <> toy_id, payload, socket) do
    case PlayChannel.Inventory.get_toy!(toy_id) do
      nil ->  {:error, %{reason: "channel: No such toy #{toy_id}"}}
      toy ->
        IO.puts "found toy : #{IO.inspect toy.id}"
        {:ok, toy_to_map(toy), socket}
    end
  end

  def handle_out(event, payload, socket) do
    push socket, event, payload
  end

  def broadcast_change(toy) do
    payload = toy_to_map(toy)
    PlayChannelWeb.Endpoint.broadcast("toys:#{toy.id}", "change", payload)
  end

  defp toy_to_map(toy) do
    %{
      "name" => toy.name,
      "color" => toy.color,
      "age" => toy.age,
      "id" => toy.id
    }
  end
end
