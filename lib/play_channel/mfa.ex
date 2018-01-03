defmodule PlayChannel.Mfa do
  defstruct [module: "Inventory", function: "list_toys", arguments: []]

  alias PlayChannel.Mfa

  # def execute(payload = %PlayChannel.Mfa{} ) do
  # def execute(%{} = payload) do
  def execute(opts) do
    IO.puts "execute payload: "
    IO.inspect opts
    mfa = %PlayChannel.Mfa{module: mod, function: func, arguments: args} = struct(Mfa, opts)
    IO.inspect mfa
    result = apply(String.to_existing_atom("Elixir.PlayChannel." <> mod),
          String.to_existing_atom(func),
          args)
    last = convert_structs_to_maps(result)

    IO.puts "last result = "
    IO.inspect last
    last
  end


  def convert_structs_to_maps(list) do
    IO.puts "convert structs to maps"
    IO.inspect list
    list
    |> Enum.map(fn x ->
      IO.puts "enum each "
      IO.inspect x
      r = Map.drop(x, [:__struct__, :__meta__])
      IO.inspect r
      r
    end)
  end

end
