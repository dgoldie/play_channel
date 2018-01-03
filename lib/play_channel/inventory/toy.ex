defmodule PlayChannel.Inventory.Toy do
  use Ecto.Schema
  import Ecto.Changeset
  alias PlayChannel.Inventory.Toy


  schema "toys" do
    field :age, :integer
    field :color, :string
    field :name, :string

    timestamps()
  end

  @doc false
  def changeset(%Toy{} = toy, attrs) do
    toy
    |> cast(attrs, [:name, :color, :age])
    |> validate_required([:name, :color, :age])
  end

  defimpl Poison.Encoder, for: Toy do
    def encode(model, opts) do
      model
        |> Map.take([:age, :color, :name])
        |> Poison.Encoder.encode(opts)
    end
  end
end
