defmodule NinetyNine.Utils.Math do
  @moduledoc """
  Utilities for computing math functions
  """

  @doc """
  Raises a to the power b

  ## Usage
    iex> import NinetyNine.Utils.Math
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
      iex> import NinetyNine.Utils.Math
      iex> (1 == abs_(-1)) and (1 == abs_(1))
      true
  """
  def abs_(n) when n < 0, do: -1 * n
  def abs_(n), do: n

  @doc """
  Computes if two numbers are close to each other.

  ## Usage

      iex> import NinetyNine.Utils.Math
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
end
