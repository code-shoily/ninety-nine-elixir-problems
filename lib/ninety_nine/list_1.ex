defmodule NinetyNine.List1 do
  @moduledoc """
  First ten problems. [P01 ~ P20]
  """
  import NinetyNine.ListUtils

  @doc """
  [P01] Find the last element of a list.

  ## Examples

      iex> NinetyNine.List1.last_element([1,2,3])
      3

      iex> NinetyNine.List1.last_element([])
      nil

  """
  def last_element([]), do: nil
  def last_element([x]), do: x
  def last_element([_ | xs]), do: last_element(xs)

  @doc """
  [P02] Find the last but one element of a list.

  ## Examples

      iex> NinetyNine.List1.last_but_one([0,1,2,3])
      2

      iex> NinetyNine.List1.last_but_one([0])
      nil

      iex> NinetyNine.List1.last_but_one([])
      nil

  """
  def last_but_one([x, _]), do: x
  def last_but_one([_, x | xs]), do: last_but_one([x | xs])
  def last_but_one(_), do: nil

  @doc """
  [P03] Find the K'th element of a list.

  ## Examples

      iex> NinetyNine.List1.kth_element([1,2,3,4,5], 2)
      3

  """
  def kth_element(xs, idx), do: at(xs, idx)

  @doc """
  [P04] Find the number of elements of a list.

  ## Examples

      iex> NinetyNine.List1.number_of_elements([])
      0

      iex> NinetyNine.List1.number_of_elements([1,2,3])
      3

  """
  def number_of_elements(xs), do: len(xs)

  @doc """
  [P05] Reverse a list.

  ## Examples

      iex> NinetyNine.List1.reverse_list([1,2,3])
      [3,2,1]

      iex> NinetyNine.List1.reverse_list([1])
      [1]

      iex> NinetyNine.List1.reverse_list([])
      []

  """
  def reverse_list(xs), do: reverse(xs)

  @doc """
  [P06] Find out whether a list is a palindrome.

  ## Examples

      iex> NinetyNine.List1.palindrome?([1,2,3,4,5])
      false

      iex> NinetyNine.List1.palindrome?([1,2,3,2,1])
      true

  """
  def palindrome?(xs), do: xs === reverse(xs)

  @doc """
  [P07] Transform a list, possibly holding lists as elements into
  a `flat' list by replacing each list with its elements (recursively).

  ## Examples

      iex> NinetyNine.List1.flatten_list([[1,2], 3, 4])
      [1,2,3,4]

      iex> NinetyNine.List1.flatten_list([1,2,3,4,[[6,7],8]])
      [1,2,3,4,6,7,8]

      iex> NinetyNine.List1.flatten_list([1,[2, [3]]])
      [1,2,3]

      iex> NinetyNine.List1.flatten_list([1,2,3,4,5])
      [1,2,3,4,5]
  """
  def flatten_list(xs), do: flatten(xs)

  @doc """
  [P08] Eliminate consecutive duplicates of list elements.

  ## Examples

      iex> NinetyNine.List1.dup([1,1,1,2,3,3,4,4,4,1,1,2,3,3,5])
      [1,2,3,4,1,2,3,5]

      iex> NinetyNine.List1.dup([1,2,2,3,4])
      [1,2,3,4]

      iex> NinetyNine.List1.dup([1,2,3,4])
      [1,2,3,4]
  """
  def dup([]), do: []
  def dup([x1, x2 | xs]) when x1 == x2, do: dup([x1] ++ xs)
  def dup([x | xs]), do: [x] ++ dup(xs)

  @doc """
  [P09] Pack consecutive duplicates of list elements into sublists.

  ## Examples

      iex> NinetyNine.List1.pack_repetitions([1,2,3,4])
      [[1], [2], [3], [4]]

      iex> NinetyNine.List1.pack_repetitions([])
      []

      iex> NinetyNine.List1.pack_repetitions([1,1,1,1,2,2,2,3,3,1,1,3,4,2])
      [[1,1,1,1],[2,2,2],[3,3],[1,1],[3],[4],[2]]
  """
  def pack_repetitions([]), do: []

  def pack_repetitions(xs) do
    [:end | xs]
    |> sublistify()
    |> Enum.reduce(&merge_if_equal(&1, &2))
    |> reverse()
    |> tl()
  end

  @doc """
  [P10] Run-length encoding of a list.

  ## Examples

      iex> NinetyNine.List1.run_length_encoding([:a,:b,:c,:d])
      [{1, :a}, {1, :b}, {1, :c}, {1, :d}]

      iex> NinetyNine.List1.run_length_encoding([])
      []

      iex> NinetyNine.List1.run_length_encoding([:a,:a,:a,:a,:b,:b,:b,:c,:a])
      [{4,:a},{3,:b}, {1, :c}, {1, :a}]
  """
  def run_length_encoding(lst) do
    for [x | _] = xs <- lst |> pack_repetitions(), do: {len(xs), x}
  end
end