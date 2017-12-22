defmodule PlayChannel.InventoryTest do
  use PlayChannel.DataCase

  alias PlayChannel.Inventory

  describe "toys" do
    alias PlayChannel.Inventory.Toy

    @valid_attrs %{age: 42, color: "some color", name: "some name"}
    @update_attrs %{age: 43, color: "some updated color", name: "some updated name"}
    @invalid_attrs %{age: nil, color: nil, name: nil}

    def toy_fixture(attrs \\ %{}) do
      {:ok, toy} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Inventory.create_toy()

      toy
    end

    test "list_toys/0 returns all toys" do
      toy = toy_fixture()
      assert Inventory.list_toys() == [toy]
    end

    test "get_toy!/1 returns the toy with given id" do
      toy = toy_fixture()
      assert Inventory.get_toy!(toy.id) == toy
    end

    test "create_toy/1 with valid data creates a toy" do
      assert {:ok, %Toy{} = toy} = Inventory.create_toy(@valid_attrs)
      assert toy.age == 42
      assert toy.color == "some color"
      assert toy.name == "some name"
    end

    test "create_toy/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Inventory.create_toy(@invalid_attrs)
    end

    test "update_toy/2 with valid data updates the toy" do
      toy = toy_fixture()
      assert {:ok, toy} = Inventory.update_toy(toy, @update_attrs)
      assert %Toy{} = toy
      assert toy.age == 43
      assert toy.color == "some updated color"
      assert toy.name == "some updated name"
    end

    test "update_toy/2 with invalid data returns error changeset" do
      toy = toy_fixture()
      assert {:error, %Ecto.Changeset{}} = Inventory.update_toy(toy, @invalid_attrs)
      assert toy == Inventory.get_toy!(toy.id)
    end

    test "delete_toy/1 deletes the toy" do
      toy = toy_fixture()
      assert {:ok, %Toy{}} = Inventory.delete_toy(toy)
      assert_raise Ecto.NoResultsError, fn -> Inventory.get_toy!(toy.id) end
    end

    test "change_toy/1 returns a toy changeset" do
      toy = toy_fixture()
      assert %Ecto.Changeset{} = Inventory.change_toy(toy)
    end
  end
end
