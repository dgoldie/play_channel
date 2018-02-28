defmodule PlayChannel.LiveManager do
  # defstruct [module: "Inventory", function: "list_toys", arguments: []]

  alias PlayChannel.LiveManager
  alias PlayChannel.Inventory

  # def execute(payload = %PlayChannel.Live{} ) do
  # def execute(%{} = payload) do
  # def execute(opts) do
  #   IO.puts "execute payload: "
  #   IO.inspect opts
  #   mfa = %PlayChannel.LiveManager{module: mod, function: func, arguments: args} = struct(LiveManager, opts)
  #   IO.inspect mfa
  #   result = apply(String.to_existing_atom("Elixir.PlayChannel." <> mod),
  #         String.to_existing_atom(func),
  #         args)
  #   last = convert_structs_to_maps(result)

  #   IO.puts "last result = "
  #   IO.inspect last
  #   last
  # end

  def rest("list_toys") do
    IO.puts "list_toys ****"
    toys = Inventory.list_toys
    IO.inspect toys
    html = Phoenix.View.render_to_string(
      PlayChannelWeb.ToyView,
      "list.html",
      [toys: toys]
    )
    IO.inspect html
    html
    # |> convert_structs_to_maps
  end


  def rest("show_toy", id) do
    IO.puts "show_toy"
    toy  = Inventory.get_toy!(id)
    html = Phoenix.View.render_to_string(
      PlayChannelWeb.ToyView,
      "show.html",
      [toy: toy]
    )
    IO.inspect html
    html
    # |> convert_structs_to_maps
  end

  def direct(mod, func, args \\ []) do
    apply(String.to_existing_atom("Elixir.PlayChannel." <> mod),
          String.to_existing_atom(func),
          args)
    |> convert_structs_to_maps
  end

  # TODO: must be better way!
  #
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
