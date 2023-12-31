defmodule Day12Test do
  use ExUnit.Case
  doctest Day12

  @tag :skip
  test "test part1 with sample" do
    output = File.read!("sample.txt")
    |> Day12.part1()
    assert output == 21
  end

  @tag :skip
  test "test part1 with input" do
    output = File.read!("input.txt")
    |> Day12.part1()
    assert output == 8270
  end
end
