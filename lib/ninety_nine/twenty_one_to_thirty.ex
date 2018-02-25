defmodule NinetyNine.TwentyOneToThirty do
  @moduledoc """
  Problems 21 ~ 30 Solved
  """

  @doc """
  [P21] Insert an element at a given position into a list.

  ## Examples

      iex> NinetyNine.TwentyOneToThirty.insert_at([1, 2, 3, 4, 5], 2, :x)
      [1, :x, 2, 3, 4, 5]
      
      iex> NinetyNine.TwentyOneToThirty.insert_at([1, 2, 3, 4, 5], -1, :x)
      [1, 2, 3, 4, 5]
      
      iex> NinetyNine.TwentyOneToThirty.insert_at([1, 2, 3, 4, 5], 100, :x)
      [1, 2, 3, 4, 5]
  """
  def insert_at(xs, pos, item), do: insert_at(xs, pos, item, 1, [])

  def insert_at([x | xs], pos, item, ctr, res) when pos != ctr,
    do: insert_at(xs, pos, item, ctr + 1, res ++ [x])

  def insert_at([x | xs], pos, item, ctr, res) when pos == ctr,
    do: insert_at(xs, pos, item, ctr + 1, res ++ [item] ++ [x])

  def insert_at([], _, _, _, res), do: res

  @doc """
  [P22] Create a list containing all integers within a given range.

  ## Examples
      
      iex> NinetyNine.TwentyOneToThirty.range(1, 1)
      [1]

      iex> NinetyNine.TwentyOneToThirty.range(1, 5)
      [1,2,3,4,5]

      iex> NinetyNine.TwentyOneToThirty.range(23, 21)
      [23, 22, 21]
  """
  def range(a, b) when a <= b, do: range_up(a, b, [])
  def range(a, b) when a > b, do: range_down(a, b, [])

  def range_up(a, b, res) when a <= b, do: range_up(a + 1, b, res ++ [a])
  def range_up(a, b, res) when a > b, do: res

  def range_down(a, b, res) when a >= b, do: range_down(a - 1, b, res ++ [a])
  def range_down(a, b, res) when a < b, do: res
end
