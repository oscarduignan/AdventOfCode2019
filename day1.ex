defmodule Day1 do
  def mass2fuel(mass) do
    fuel =
      mass
      |> Integer.floor_div(3)
      |> Kernel.-(2)

    if fuel <= 0 do
      0
    else
      fuel + mass2fuel(fuel)
    end
  end
end

"inputs/day1"
|> File.read!()
|> String.trim()
|> String.split("\n")
|> Enum.map(fn mass ->
  mass
  |> String.to_integer()
  |> Integer.floor_div(3)
  |> Kernel.-(2)
end)
|> Enum.sum()
|> IO.inspect(label: "Part 1")

"inputs/day1"
|> File.read!()
|> String.trim()
|> String.split("\n")
|> Enum.map(fn mass ->
  mass
  |> String.to_integer()
  |> Day1.mass2fuel()
end)
|> Enum.sum()
|> IO.inspect(label: "Part 2")

# we know should need 50346 fuel
100_756
|> Day1.mass2fuel()
|> IO.inspect(label: "100756")
