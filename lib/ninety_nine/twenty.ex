defmodule NinetyNine.Twenty do
  @moduledoc """
  First twenty problems. [P01 ~ P20]
  """
  import NinetyNine.Utils

  @doc """
  [P01] Find the last element of a list.
    
    ## Usage
    iex> NinetyNine.Twenty.last_element([1,2,3])
    3
    iex> NinetyNine.Twenty.last_element([])
    nil
  """
  def last_element([]), do: nil
  def last_element([elem]), do: elem
  def last_element([_ | t]), do: last_element(t)

  @doc """
  [P02] Find the last but one element of a list.

    ##Usage
    iex> NinetyNine.Twenty.last_but_one([0,1,2,3])
    2
    iex> NinetyNine.Twenty.last_but_one([0])
    nil

    iex> NinetyNine.Twenty.last_but_one([])
    nil
  """
  def last_but_one([a, _]), do: a
  def last_but_one([_, b | rest]), do: last_but_one([b | rest])
  def last_but_one(_), do: nil

  @doc """
  [P03] Find the K'th element of a list.

    ##Usage
    iex> NinetyNine.Twenty.kth_element([1,2,3,4,5], 2)
    3
  """
  def kth_element(lst, idx), do: at(lst, idx)

  @doc """
  [P04] Find the number of elements of a list.

    ##Usage
    iex> NinetyNine.Twenty.number_of_elements([])
    0
    iex> NinetyNine.Twenty.number_of_elements([1,2,3])
    3
  """
  def number_of_elements(lst), do: len(lst)

  @doc """
  [P05] Reverse a list.

    ##Usage
    iex> NinetyNine.Twenty.reverse_list([1,2,3])
    [3,2,1]
    iex> NinetyNine.Twenty.reverse_list([1])
    [1]
    iex> NinetyNine.Twenty.reverse_list([])
    []
  """
  def reverse_list(lst), do: reverse(lst)

  @doc """
  [P06] Find out whether a list is a palindrome.

    ##Usage
    iex> NinetyNine.Twenty.palindrome?([1,2,3,4,5])
    false
    iex> NinetyNine.Twenty.palindrome?([1,2,3,2,1])
    true
  """
  def palindrome?(lst), do: lst === reverse(lst)
end
