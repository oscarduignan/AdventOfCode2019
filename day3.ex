defmodule Day3 do
  @central_port {0,0}

  def part_one(input) do
    input
    |> parse_input
    # draw our lines and convert to sets
    |> Enum.map(fn moves ->
      moves
      |> draw_path
      |> MapSet.new
    end)
    # work out intersecting points beside central port
    |> (fn [first, second] ->
      first
      |> MapSet.intersection(second)
      |> MapSet.delete({0,0})
    end).()
    # sort by manhattan distance and return it
    |> Enum.sort_by(&distance_from_central_port/1)
    |> List.first
    |> distance_from_central_port
  end

  def draw_path(moves) do
    moves
    |> Enum.reduce([{0,0}], fn next, [last | _] = acc ->
      [add_vectors(last, next) | acc]
    end)
    |> Enum.reverse
  end

  def parse_input(input) do
    input
    |> String.trim
    |> String.split("\n")
    |> Enum.map(fn line ->
      line
      |> String.split(",")
      |> Enum.flat_map(&vector_moves/1)
    end)
  end

  defp vector_moves("U" <> n), do: repeat({0,1},  n)
  defp vector_moves("D" <> n), do: repeat({0,-1}, n)
  defp vector_moves("L" <> n), do: repeat({-1,0}, n)
  defp vector_moves("R" <> n), do: repeat({1,0},  n)

  defp repeat(thing, amount) do
    for _ <- 1..String.to_integer(amount), do: thing
  end

  defp add_vectors({a_x, a_y}, {b_x, b_y}) do
    {a_x + b_x, a_y + b_y}
  end

  defp distance_from_central_port(coord) do
    coord |> manhattan_distance(@central_port)
  end

  defp manhattan_distance({a_x, a_y}, {b_x, b_y}) do
    abs(a_x - b_x) + abs(a_y - b_y)
  end
end

ExUnit.start()

defmodule Day3Tests do
  use ExUnit.Case

  import Day3

  test "we can parse input" do
    assert parse_input("R2,D2") == [[{1,0},{1,0},{0,-1},{0,-1}]]
  end

  test "we can draw a path of vector moves from a point into a list of coords" do
    moves = [{1,0},{1,0},{0,-1},{0,-1}]

    assert draw_path(moves) == [{0,0},{1,0},{2,0},{2,-1},{2,-2}]
  end

  test "part one example matches known answer" do
    distance =
      """
      R75,D30,R83,U83,L12,D49,R71,U7,L72
      U62,R66,U55,R34,D71,R55,D58,R83
      """
      |> Day3.part_one

    assert distance == 159
  end
end

"inputs/day3"
|> File.read!
|> Day3.part_one
|> IO.inspect(label: "part one")

# The answer for my inputs was 1337! Now I definitely don't feel bad staying up :P
