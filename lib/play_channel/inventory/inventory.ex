defmodule PlayChannel.Inventory do
  @moduledoc """
  The Inventory context.
  """

  import Ecto.Query, warn: false
  alias PlayChannel.Repo

  alias PlayChannel.Inventory.Toy

  @doc """
  Returns the list of toys.

  ## Examples

      iex> list_toys()
      [%Toy{}, ...]

  """
  def list_toys do
    Repo.all(Toy)
  end

  @doc """
  Gets a single toy.

  Raises `Ecto.NoResultsError` if the Toy does not exist.

  ## Examples

      iex> get_toy!(123)
      %Toy{}

      iex> get_toy!(456)
      ** (Ecto.NoResultsError)

  """
  def get_toy!(id), do: Repo.get!(Toy, id)

  @doc """
  Creates a toy.

  ## Examples

      iex> create_toy(%{field: value})
      {:ok, %Toy{}}

      iex> create_toy(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_toy(attrs \\ %{}) do
    %Toy{}
    |> Toy.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a toy.

  ## Examples

      iex> update_toy(toy, %{field: new_value})
      {:ok, %Toy{}}

      iex> update_toy(toy, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_toy(%Toy{} = toy, attrs) do
    toy
    |> Toy.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a Toy.

  ## Examples

      iex> delete_toy(toy)
      {:ok, %Toy{}}

      iex> delete_toy(toy)
      {:error, %Ecto.Changeset{}}

  """
  def delete_toy(%Toy{} = toy) do
    Repo.delete(toy)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking toy changes.

  ## Examples

      iex> change_toy(toy)
      %Ecto.Changeset{source: %Toy{}}

  """
  def change_toy(%Toy{} = toy) do
    Toy.changeset(toy, %{})
  end
end
