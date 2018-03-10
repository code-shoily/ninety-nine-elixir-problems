defmodule NinetyNine.Arithmetic do
  @moduledoc """
  Solve the Arithmetic problems (31..41)
  """
  @doc """
  [P31] Determine whether a given integer number is prime.
  """
  def prime?(_), do: :"TODO:"

  @doc """
  [P32] Determine the greatest common divisor of two positive integer numbers.

  ## Usage
      iex> import NinetyNine.Arithmetic
      iex> gcd(36, 63)
      9
  """
  def gcd(x, 0), do: x
  def gcd(x, y), do: gcd(y, rem(x, y))
end
