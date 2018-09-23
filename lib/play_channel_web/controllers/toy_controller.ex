defmodule PlayChannelWeb.ToyController do
  use PlayChannelWeb, :controller

  alias PlayChannel.Inventory
  alias PlayChannel.Inventory.Toy

  def index(conn, _params) do
    toys = Inventory.list_toys()
    render(conn, "index.html", toys: toys)
  end

  def new(conn, _params) do
    changeset = Inventory.change_toy(%Toy{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"toy" => toy_params}) do
    case Inventory.create_toy(toy_params) do
      {:ok, toy} ->
        conn
        |> put_flash(:info, "Toy created successfully.")
        |> redirect(to: toy_path(conn, :show, toy))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    toy = Inventory.get_toy!(id)
    render(conn, "show.html", toy: toy)
  end

  def edit(conn, %{"id" => id}) do
    toy = Inventory.get_toy!(id)
    changeset = Inventory.change_toy(toy)
    render(conn, "edit.html", toy: toy, changeset: changeset)
  end

  def update(conn, %{"id" => id, "toy" => toy_params}) do
    toy = Inventory.get_toy!(id)
    # IO.puts "update toy #{inspect toy}"

    case Inventory.update_toy(toy, toy_params) do
      {:ok, toy} ->
        PlayChannelWeb.ToyChannel.broadcast_change(toy)

        conn
        |> put_flash(:info, "Toy updated successfully.")
        |> redirect(to: toy_path(conn, :show, toy))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", toy: toy, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    toy = Inventory.get_toy!(id)
    {:ok, _toy} = Inventory.delete_toy(toy)

    conn
    |> put_flash(:info, "Toy deleted successfully.")
    |> redirect(to: toy_path(conn, :index))
  end
end
