defmodule NinetyNine.Arithmetic do
  @moduledoc """
  Solve the Arithmetic problems (31..41)
  """
  import NinetyNine.ListUtils, only: [len: 1]

  @doc """
  [P31] Determine whether a given integer number is prime.

  ## Usage

      iex> import NinetyNine.Arithmetic
      iex> prime?(7879)
      true
      iex> prime?(9)
      false
  """
  def prime?(n) when n <= 0, do: false
  def prime?(n) when 0 < n and n <= 3, do: true

  def prime?(n) when rem(n, 2) == 0, do: false

  def prime?(n) do
    # TODO: Replace with SQRT
    not (2..(n - 1)
         |> Enum.filter(&(rem(n, &1) == 0))
         |> Enum.any?())
  end

  @doc """
  [P32] Determine the greatest common divisor of two positive integer numbers.

  ## Usage
      iex> import NinetyNine.Arithmetic
      iex> gcd(36, 63)
      9
  """
  def gcd(x, 0), do: x
  def gcd(x, y), do: gcd(y, rem(x, y))

  @doc """
  [P33] Determine whether two positive integer numbers are coprime.

  ## Usage
      iex> import NinetyNine.Arithmetic
      iex> coprime?(35, 64)
      true
  """
  def coprime?(x, y), do: gcd(x, y) == 1

  @doc """
  [P34] Calculate Euler's totient function phi(m).
  """
  def naive_phi(1), do: 1
  def naive_phi(n) when n < 1, do: :error

  def naive_phi(n),
    do:
      1..(n - 1)
      |> Enum.filter(&coprime?(&1, n))
      |> len()
end
