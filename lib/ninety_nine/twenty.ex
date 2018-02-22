defmodule NinetyNine.Twenty do
  @moduledoc """
  First twenty problems. [P01 ~ P20]
  """
  import NinetyNine.Utils

  @doc """
  [P01] Find the last element of a list.
    
  ## Examples

      iex> NinetyNine.Twenty.last_element([1,2,3])
      3

      iex> NinetyNine.Twenty.last_element([])
      nil

  """
  def last_element([]), do: nil
  def last_element([x]), do: x
  def last_element([_ | xs]), do: last_element(xs)

  @doc """
  [P02] Find the last but one element of a list.

  ## Examples

      iex> NinetyNine.Twenty.last_but_one([0,1,2,3])
      2

      iex> NinetyNine.Twenty.last_but_one([0])
      nil

      iex> NinetyNine.Twenty.last_but_one([])
      nil

  """
  def last_but_one([x, _]), do: x
  def last_but_one([_, x | xs]), do: last_but_one([x | xs])
  def last_but_one(_), do: nil

  @doc """
  [P03] Find the K'th element of a list.

  ## Examples

      iex> NinetyNine.Twenty.kth_element([1,2,3,4,5], 2)
      3

  """
  def kth_element(xs, idx), do: at(xs, idx)

  @doc """
  [P04] Find the number of elements of a list.

  ## Examples

      iex> NinetyNine.Twenty.number_of_elements([])
      0

      iex> NinetyNine.Twenty.number_of_elements([1,2,3])
      3

  """
  def number_of_elements(xs), do: len(xs)

  @doc """
  [P05] Reverse a list.

  ## Examples

      iex> NinetyNine.Twenty.reverse_list([1,2,3])
      [3,2,1]

      iex> NinetyNine.Twenty.reverse_list([1])
      [1]

      iex> NinetyNine.Twenty.reverse_list([])
      []

  """
  def reverse_list(xs), do: reverse(xs)

  @doc """
  [P06] Find out whether a list is a palindrome.

  ## Examples

      iex> NinetyNine.Twenty.palindrome?([1,2,3,4,5])
      false

      iex> NinetyNine.Twenty.palindrome?([1,2,3,2,1])
      true

  """
  def palindrome?(xs), do: xs === reverse(xs)

  @doc """
  [P07] Transform a list, possibly holding lists as elements into 
  a `flat' list by replacing each list with its elements (recursively).

  ## Examples

      iex> NinetyNine.Twenty.flatten_list([[1,2], 3, 4])
      [1,2,3,4]

      iex> NinetyNine.Twenty.flatten_list([1,2,3,4,[[6,7],8]])
      [1,2,3,4,6,7,8]

      iex> NinetyNine.Twenty.flatten_list([1,[2, [3]]])
      [1,2,3]

      iex> NinetyNine.Twenty.flatten_list([1,2,3,4,5])
      [1,2,3,4,5]
  """
  def flatten_list(xs), do: flatten(xs)

  @doc """
  [P08] Eliminate consecutive duplicates of list elements.

  ## Examples

      iex> NinetyNine.Twenty.dup([1,1,1,2,3,3,4,4,4,1,1,2,3,3,5])
      [1,2,3,4,1,2,3,5]
      
      iex> NinetyNine.Twenty.dup([1,2,2,3,4])
      [1,2,3,4]

      iex> NinetyNine.Twenty.dup([1,2,3,4])
      [1,2,3,4]
  """
  def dup([]), do: []
  def dup([x1, x2 | xs]) when x1 == x2, do: dup([x1] ++ xs)
  def dup([x | xs]), do: [x] ++ dup(xs)
end
