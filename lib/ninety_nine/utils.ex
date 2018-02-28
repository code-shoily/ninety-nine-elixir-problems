defmodule NinetyNine.Utils do
  @moduledoc """
  Reusable utility functions for the rest of the problems.
  """

  @doc """
  Length of a list.

  ## Examples

      iex> NinetyNine.Utils.len([])
      0

      iex> NinetyNine.Utils.len([1,2,3])
      3

  """
  def len(lst), do: len(lst, 0)
  def len([], n), do: n
  def len([_ | xs], n), do: len(xs, n + 1)

  @doc """
  Repeats each element n times

  ## Examples
      
      iex> NinetyNine.Utils.repeat(:a, 3)
      [:a, :a, :a]
      iex> NinetyNine.Utils.repeat(:b, 0)
      []
  """
  def repeat(a, n), do: repeat(a, n + 1, [])

  def repeat(_, 0, _), do: []
  def repeat(_, 1, lst), do: lst
  def repeat(a, n, lst), do: repeat(a, n - 1, [a | lst])

  @doc """
  Reverses a list. See `Enum.reverse`

  ## Examples

      iex> NinetyNine.Utils.reverse([1,2,3])
      [3,2,1]

      iex> NinetyNine.Utils.reverse([1])
      [1]

      iex> NinetyNine.Utils.reverse([])
      []

  """
  def reverse(xs), do: reverse(xs, [])
  def reverse([], xs), do: xs
  def reverse([x | xs], acc), do: reverse(xs, [x | acc])

  @doc """
  Returns the n-th element of a list.

  ## Examples

      iex> NinetyNine.Utils.at([1,2,3], 2)
      3

      iex> NinetyNine.Utils.at([], -1)
      :nil

  """
  def at([x | _], 0), do: x

  def at([_ | xs], idx), do: at(xs, idx - 1)

  def at(_, _), do: nil

  @doc """
  Flattens a nested list.
  TODO: Optimize this one?

  ## Examples

      iex> NinetyNine.Utils.flatten([[1,2], 3, 4])
      [1,2,3,4]

      iex> NinetyNine.Utils.flatten([1,2,3,4,[[6,7],8]])
      [1,2,3,4,6,7,8]

      iex> NinetyNine.Utils.flatten([1, [2, [3]]])
      [1,2,3]

      iex> NinetyNine.Utils.flatten([1,2,3,4,5])
      [1,2,3,4,5]

  """
  def flatten([]), do: []
  def flatten([[_ | _] = x | xs]), do: flatten(x) ++ flatten(xs)
  def flatten([x | xs]), do: [x] ++ flatten(xs)
  def flatten(_), do: nil

  @doc """
  Packs all elements of an enumerable into its own list.

  ## Examples

      iex> NinetyNine.Utils.sublistify([])
      []

      iex> NinetyNine.Utils.sublistify([1,2,2,3])
      [[1], [2], [2], [3]]
  """
  def sublistify(xs) do
    xs |> Enum.map(&[&1])
  end

  @doc """
  Compares two lists and if their heads are the same, then
  contatenates those elements, otherwise, returns both the lists.

  ## Examples

  """
  def merge_if_equal([x | _] = xs, [[y | _] = ys | rest]) when x == y do
    [xs ++ ys | rest]
  end

  def merge_if_equal(xs, ys) when is_list(xs) do
    [xs | ys]
  end

  @doc """
  [P17] Split a list into two parts; the length of the first part is given.

  ## Example
      
      iex> NinetyNine.Utils.split_at([:a, :b, :c, :d, :e, :f, :g, :h, :i, :k], 3)
      [[:a, :b, :c], [:d, :e, :f, :g, :h, :i, :k]]

      iex> NinetyNine.Utils.split_at([1,2,3], -1)
      [[1,2,3], []]

      iex> NinetyNine.Utils.split_at([1,2,3], 10)
      [[1,2,3], []]

  """
  def split_at([], _), do: [[], []]
  def split_at(lst, n) when n <= 0, do: [lst, []]
  def split_at(lst, n), do: split_at(lst, n, 0, [[], []])

  def split_at(_, n, ctr, res) when n <= ctr, do: res
  def split_at([x | xs], n, ctr, [lst, _]), do: split_at(xs, n, ctr + 1, [lst ++ [x], xs])
  def split_at([], _, _, res), do: res

  @doc """
  Finds a number within the range given.
  """
  def rand_range(from, to) do
    from + :rand.uniform(to)
  end

  @doc """
  Remove the K'th element from a list and return removed element and new list.

  ## Examples

      iex> NinetyNine.Utils.remove_at([1,2,3,4,5], 3)
      {3, [1,2,4,5]}

      iex> NinetyNine.Utils.remove_at([1,2,3,4,5], 1)
      {1, [2,3,4,5]}

      iex> NinetyNine.Utils.remove_at([1,2,3,4,5], 3)
      {3, [1,2,4,5]}
  """
  def remove_at(xs, n), do: remove_at(xs, n, 1, {nil, []})
  def remove_at([], _, _, res), do: res
  def remove_at([x | xs], n, ctr, {_, res}) when ctr == n, do: {x, res ++ xs}
  def remove_at([x | xs], n, ctr, {val, res}), do: remove_at(xs, n, ctr + 1, {val, res ++ [x]})
end
