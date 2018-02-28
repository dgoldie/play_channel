defmodule PlayChannelWeb.LiveChannel do
  use PlayChannelWeb, :channel

  alias PlayChannel.Inventory

  def join("live:" <> topic, _payload, socket) do
    IO.puts "JOIN live TOPIC = #{topic}"
    # case PlayChannel.Mfa.execute(payload) do
    #   nil ->  {:error, %{reason: "channel: No such mfa"}}
    #   answer ->
    #     IO.puts "found result : "
    #     IO.inspect answer
    #     {:ok, answer, socket}
    # end
    {:ok, socket}
  end

  def handle_in("live:paint_it", %{"color" => "blue", "text" => text}, socket) do
    PlayChannelWeb.LiveToysView
    |> Phoenix.View.render_to_string("blue.html", text: text)
    |> broadcast_html(socket)
  end

  def handle_in("live:paint_it", %{"color" => "red", "text" => text}, socket) do
    PlayChannelWeb.LiveToysView
    |> Phoenix.View.render_to_string("red.html", text: text)
    |> broadcast_html(socket)
  end

  #NOTE: should we pass map?
  #
  def handle_in("live:rest", payload, socket) do
    IO.puts "handle_in live rest !@!@@"

    # we know were listing toys.
    #
    html = PlayChannel.LiveManager.rest("list_toys")
    # html = PlayChannel.LiveManager.rest("show_toy", 1)
    {:reply, {:ok, %{data: html}}, socket}
  end

  def handle_in(event, payload, socket) do
    IO.puts "last handle in"
    IO.inspect event
    IO.inspect payload
    mod  = payload["module"]
    func = payload["function"]
    args = payload["args"] || []
    case PlayChannel.LiveManager.direct(mod, func, args) do
      nil ->  {:error, %{reason: "channel: No such live channel"}}
      response ->
        IO.puts "found response : "
        IO.inspect response

        {:reply, {:ok, %{data: response}}, socket}
    end
  end


  def handle_out(event, payload, socket) do
    IO.puts "handle_out: "
    push socket, event, payload
  end

  defp broadcast_html(html, socket) do
    broadcast!(socket, "live_response", %{html: html})
    {:noreply, socket}
  end
end
