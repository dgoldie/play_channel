defmodule PlayChannelWeb.DirectToysController do
  use PlayChannelWeb, :controller


  def index(conn,  _params) do
    render(conn, "index.html")
  end
end
