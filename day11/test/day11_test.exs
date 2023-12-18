defmodule Day11Test do
  use ExUnit.Case
  doctest Day11

  test "part 1 with sample" do
    input = File.read!("test_input.txt")
    assert Day11.solve(input) == 374
  end

  test "part 1 with actual input" do
    input = File.read!("input.txt")
    assert Day11.solve(input) == 9623138
  end

  test "part 2 with sample and expanse 10" do
    input = File.read!("test_input.txt")
    assert Day11.solve(input, 10) == 1030
  end

  test "part 2 with sample and expanse 100" do
    input = File.read!("test_input.txt")
    assert Day11.solve(input, 100) == 8410
  end

  test "part 2 with actual input and expanse 1000000" do
    input = File.read!("input.txt")
    assert Day11.solve(input, 1000000) == 726820169514
  end
end
