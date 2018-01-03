defmodule PlayChannelWeb.MfaChannel do
  use PlayChannelWeb, :channel

  def join("mfa" <> topic, _payload, socket) do
    IO.puts "JOIN mfa TOPIC = #{topic}"
    # case PlayChannel.Mfa.execute(payload) do
    #   nil ->  {:error, %{reason: "channel: No such mfa"}}
    #   answer ->
    #     IO.puts "found result : "
    #     IO.inspect answer
    #     {:ok, answer, socket}
    # end
    {:ok, socket}
  end

  def handle_in(event, payload, socket) do
    IO.puts "handle_in"
    case PlayChannel.Mfa.execute(payload) do
      nil ->  {:error, %{reason: "channel: No such mfa"}}
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
end
