defmodule PlayChannelWeb.ToyControllerTest do
  use PlayChannelWeb.ConnCase

  alias PlayChannel.Inventory

  @create_attrs %{age: 42, color: "some color", name: "some name"}
  @update_attrs %{age: 43, color: "some updated color", name: "some updated name"}
  @invalid_attrs %{age: nil, color: nil, name: nil}

  def fixture(:toy) do
    {:ok, toy} = Inventory.create_toy(@create_attrs)
    toy
  end

  describe "index" do
    test "lists all toys", %{conn: conn} do
      conn = get conn, toy_path(conn, :index)
      assert html_response(conn, 200) =~ "Listing Toys"
    end
  end

  describe "new toy" do
    test "renders form", %{conn: conn} do
      conn = get conn, toy_path(conn, :new)
      assert html_response(conn, 200) =~ "New Toy"
    end
  end

  describe "create toy" do
    test "redirects to show when data is valid", %{conn: conn} do
      conn = post conn, toy_path(conn, :create), toy: @create_attrs

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == toy_path(conn, :show, id)

      conn = get conn, toy_path(conn, :show, id)
      assert html_response(conn, 200) =~ "Show Toy"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post conn, toy_path(conn, :create), toy: @invalid_attrs
      assert html_response(conn, 200) =~ "New Toy"
    end
  end

  describe "edit toy" do
    setup [:create_toy]

    test "renders form for editing chosen toy", %{conn: conn, toy: toy} do
      conn = get conn, toy_path(conn, :edit, toy)
      assert html_response(conn, 200) =~ "Edit Toy"
    end
  end

  describe "update toy" do
    setup [:create_toy]

    test "redirects when data is valid", %{conn: conn, toy: toy} do
      conn = put conn, toy_path(conn, :update, toy), toy: @update_attrs
      assert redirected_to(conn) == toy_path(conn, :show, toy)

      conn = get conn, toy_path(conn, :show, toy)
      assert html_response(conn, 200) =~ "some updated color"
    end

    test "renders errors when data is invalid", %{conn: conn, toy: toy} do
      conn = put conn, toy_path(conn, :update, toy), toy: @invalid_attrs
      assert html_response(conn, 200) =~ "Edit Toy"
    end
  end

  describe "delete toy" do
    setup [:create_toy]

    test "deletes chosen toy", %{conn: conn, toy: toy} do
      conn = delete conn, toy_path(conn, :delete, toy)
      assert redirected_to(conn) == toy_path(conn, :index)
      assert_error_sent 404, fn ->
        get conn, toy_path(conn, :show, toy)
      end
    end
  end

  defp create_toy(_) do
    toy = fixture(:toy)
    {:ok, toy: toy}
  end
end
