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
  def len([]), do: 0
  def len([_ | t]), do: 1 + len(t)

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
  def reverse([]), do: []
  def reverse([h | t]), do: reverse(t) ++ [h]

  @doc """
  Returns the n-th element of a list.

  ## Examples

      iex> NinetyNine.Utils.at([1,2,3], 2)
      3

      iex> NinetyNine.Utils.at([], 100)
      nil

  """
  def at([h | _], 0), do: h

  def at([_ | t], n) when n >= 0, do: at(t, n - 1)

  def at(_, _), do: nil

  @doc """
  Flattens a nested list.

  ## Examples

      iex> NinetyNine.Utils.flatten([1,2,3,4,[[6,7],8]])
      [1,2,3,4,5,6,7,8]

      iex> NinetyNine.Utils.flatten([1,[2, [3]]])
      [1,2,3]

      iex> NinetyNine.Utils.flatten([1,2,3,4,5])
      [1,2,3,4,5]

  """
  def flatten([]), do: []
  def flatten([_h | _t]), do: :i_am_sleepy
  def flatten(_), do: nil
end
