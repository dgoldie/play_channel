defmodule PlayChannelWeb.MfaController do
  use PlayChannelWeb, :controller


  def index(conn,  %{"id" => id}) do
    render(conn, "index.html", id: id)
  end
end
