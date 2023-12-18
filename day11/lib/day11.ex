defmodule Day11 do
  def solve(input, expanse \\ 2) do
    galaxies = get_galaxies(input)

    lines = String.split(input, "\n", trim: true)
    {n_rows, n_cols} = {length(lines), String.length(hd(lines))}

    expanded_rows = 0..(n_rows-1) |> MapSet.new()
    expanded_cols = 0..(n_cols-1) |> MapSet.new()

    {expanded_rows, expanded_cols} = Enum.reduce(galaxies, {expanded_rows, expanded_cols}, fn {x, y}, {er, ec} -> 
      er = MapSet.delete(er, x)
      ec = MapSet.delete(ec, y)
      {er, ec}
    end)

    expanse = expanse - 1 # we are already counting them once before
    find_distance(galaxies, expanded_rows, expanded_cols, expanse) 
    |> Enum.sum()
  end

  defp find_distance([_ | []], _, _, _), do: []
  defp find_distance([hd | tail], er, ec, expanse) do
    distances = Enum.map(tail, fn t -> find_pairwise_distance(hd, t, er, ec, expanse) end)
    total_distance = Enum.sum(distances)
    [total_distance | find_distance(tail, er, ec, expanse)]
  end

  defp find_pairwise_distance({x1, y1}, {x2, y2}, er, ec, expanse) do
    x_min = min(x1, x2)
    x_max = max(x1, x2)
    y_min = min(y1, y2)
    y_max = max(y1, y2)
    
    expanded_row_len = Enum.count(x_min..x_max, & MapSet.member?(er, &1))
    expanded_col_len = Enum.count(y_min..y_max, & MapSet.member?(ec, &1))
    expansion = (expanded_col_len * expanse) + (expanded_row_len * expanse)
    (x_max - x_min) + (y_max - y_min) + expansion
  end

  defp get_galaxies(data) do
    data
    |> String.split("\n", trim: true)
    |> Enum.with_index()
    |> Enum.reduce([], fn {line, row_idx}, acc -> 
      String.to_charlist(line)
      |> Enum.with_index()
      |> Enum.reduce(acc, fn {ch, col_idx}, inner_acc -> 
        case ch do
          ?# -> [{row_idx, col_idx} | inner_acc]
          _ -> inner_acc
        end
      end)
    end)
  end
end
