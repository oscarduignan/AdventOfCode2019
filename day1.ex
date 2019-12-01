defmodule Day1 do
end

case System.argv() do
  [] ->
    ExUnit.start()

    defmodule Day1Test do
      use ExUnit.Case

      import Day1

      test "Part 1" do
        assert true
      end
    end
end
