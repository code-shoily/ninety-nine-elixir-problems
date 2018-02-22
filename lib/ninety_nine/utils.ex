defmodule NinetyNine.Utils do
  @doc """
  Length of a list.

    ##Usage
    iex> NinetyNine.Utils.len([])
    0
    iex> NinetyNine.Utils.len([1,2,3])
    3
  """
  def len([]), do: 0
  def len([h | t]), do: 1 + len(t)

  @doc """
  Reverses a list. See `Enum.reverse`

    ##Usage
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

    ##Usage
    iex> NinetyNine.Utils.at([1,2,3], 2)
    3
    iex> NinetyNine.Utils.at([], 100)
    nil
  """
  def at([h | _], 0), do: h

  def at([h | t] = lst, n) when n >= 0, do: at(t, n - 1)

  def at(_, _), do: nil
end
