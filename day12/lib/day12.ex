defmodule Day12 do
  def part1(input) do
    input
    |> String.split("\n", trim: true)
    |> Enum.map(&parse_line/1)
    |> Enum.map(fn {pattern, counts} -> 
      find_arrangement(pattern, counts, 0)
    end)
    |> Enum.sum()
  end

  defp parse_line(line) do
    [pattern, counts] = String.split(line, " ", trim: true)
    counts = String.split(counts, ",") |> Enum.map(&String.to_integer/1)
    pattern = String.to_charlist(pattern)
    {pattern, counts}
  end

  defp find_arrangement([?# | p_rest], counts, cnt), do: find_arrangement(p_rest, counts, cnt+1)
  defp find_arrangement(_, [c | _], cnt) when cnt > c, do: 0
  defp find_arrangement(_, [], cnt) when cnt > 0, do: 0
  defp find_arrangement([_ | p_rest], [c | c_rest], cnt) when c == cnt, do: find_arrangement(p_rest, c_rest, 0)
  defp find_arrangement([], [c], cnt) when c == cnt, do: 1
  defp find_arrangement([], [], 0), do: 1
  defp find_arrangement([?. | p_rest], counts, 0), do: find_arrangement(p_rest, counts, 0)
  defp find_arrangement([?? | p_rest], counts, cnt), do: find_arrangement([?. | p_rest], counts, cnt) + find_arrangement([?# | p_rest], counts, cnt)
  defp find_arrangement(_, _, _), do: 0
end

