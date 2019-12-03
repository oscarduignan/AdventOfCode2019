defmodule Day2 do
  def parse_inputs(string) do
    string
    |> String.trim()
    |> String.split(",")
    |> Enum.map(&String.to_integer/1)
  end

  def run(inputs, start_from \\ 0) do
    run(inputs, Enum.slice(inputs, start_from, 4), start_from + 4)
  end

  def run(inputs, [99 | _], _), do: inputs

  def run(inputs, [1, a, b, i], next) do
    inputs
    |> List.replace_at(i, Enum.at(inputs, a) + Enum.at(inputs, b))
    |> run(next)
  end

  def run(inputs, [2, a, b, i], next) do
    inputs
    |> List.replace_at(i, Enum.at(inputs, a) * Enum.at(inputs, b))
    |> run(next)
  end
end

"1,0,0,0,99"
|> Day2.parse_inputs()
|> Day2.run()
|> IO.inspect(label: "1,0,0,0,99")

day2 =
  "inputs/day2"
  |> File.read!()
  |> Day2.parse_inputs()

day2
|> List.replace_at(1, 12)
|> List.replace_at(2, 2)
|> Day2.run()
|> Enum.at(0)
|> IO.inspect(label: "Part 1")

permutations = for noun <- 1..100, verb <- 1..100, do: {noun, verb}

permutations
|> Enum.find(fn {noun, verb} ->
  day2
  |> List.replace_at(1, noun)
  |> List.replace_at(2, verb)
  |> Day2.run()
  |> Enum.at(0) == 19_690_720
end)
|> (fn {noun, verb} -> 100 * noun + verb end).()
|> IO.inspect(label: "Part 2")
