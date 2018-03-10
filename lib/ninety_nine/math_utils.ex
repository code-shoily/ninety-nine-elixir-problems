defmodule NinetyNine.MathUtils do
  @moduledoc """
  Utilities for computing math functions
  """

  @doc """
  Raises a to the power b

  ## Usage
    iex> import NinetyNine.MathUtils
    iex> pow(10, 0)
    1
    iex> pow(10, 1)
    10
    iex> pow(2, 3)
    8
  """
  def pow(x, n), do: pow(x, n, 1)
  def pow(_, 0, result), do: result
  def pow(x, n, result), do: pow(x, n - 1, x * result)

  @doc """
  Return the abs value.

  ## Usage
      iex> import NinetyNine.MathUtils
      iex> (1 == abs_(-1)) and (1 == abs_(1))
      true
  """
  def abs_(n) when n < 0, do: -1 * n
  def abs_(n), do: n

  @doc """
  Computes if two numbers are close to each other.

  ## Usage

      iex> import NinetyNine.MathUtils
      iex> close_enough?(10, 10.0001)
      true
      iex> close_enough?(10, 9.9999)
      true
      iex> close_enough?(10, 9.99)
      false
      iex> close_enough?(10, 10.01)
      false
  """
  def close_enough?(a, b, threshold \\ 0.001), do: abs_(a - b) <= threshold

  @doc """
  Lists all the factors of number
  """
  def factors(0), do: 0
  def factors(1), do: 1
  def factors(n), do: factors(n, 2, [])
  def factors(_, 0, res), do: res

  def factors(n, ctr, res) when ctr * ctr <= n do
    if rem(n, ctr) == 0 do
      factors(round(n / ctr), ctr, [ctr | res])
    else
      factors(n, ctr + 1, res)
    end
  end

  def factors(n, _, res) when n > 1, do: [n | res]
  def factors(_, _, res), do: res
end
