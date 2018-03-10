defmodule NinetyNine.Arithmetic do
  @moduledoc """
  Solve the Arithmetic problems (31..41)
  """
  import NinetyNine.MathUtils, only: [pow: 2]
  import NinetyNine.ListUtils, only: [len: 1]
  import NinetyNine.List1, only: [run_length_encoding: 1]

  @doc """
  [P31] Determine whether a given integer number is prime.

  ## Usage

      iex> import NinetyNine.Arithmetic
      iex> prime?(7879)
      true
      iex> prime?(9)
      false
  """
  def prime?(n) when n <= 3, do: n > 1

  def prime?(n) when rem(n, 2) == 0, do: false
  def prime?(n), do: prime?(n, 2, true)
  def prime?(n, ctr, res) when ctr >= n, do: res
  def prime?(n, ctr, _) when rem(n, ctr) == 0, do: false
  def prime?(n, ctr, _), do: prime?(n, ctr + 1, true)

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

  ## Usage
      iex> import NinetyNine.Arithmetic
      iex> naive_phi(11)
      10
      iex> naive_phi(38)
      18
  """
  def naive_phi(1), do: 1
  def naive_phi(n) when n < 1, do: :error

  def naive_phi(n),
    do:
      1..(n - 1)
      |> Enum.filter(&coprime?(&1, n))
      |> len()

  @doc """
  [P35] Lists all the prime factors of number

  ## Usage

      iex> import NinetyNine.Arithmetic
      iex> prime_factors(315)
      [3, 3, 5, 7]

  """
  def prime_factors(0), do: 0
  def prime_factors(1), do: 1
  def prime_factors(n), do: prime_factors(n, 2, [])
  def prime_factors(_, 0, res), do: res

  def prime_factors(n, ctr, res) when ctr * ctr <= n do
    if rem(n, ctr) == 0 do
      prime_factors(round(n / ctr), ctr, res ++ [ctr])
    else
      prime_factors(n, ctr + 1, res)
    end
  end

  def prime_factors(n, _, res) when n > 1, do: res ++ [n]
  def prime_factors(_, _, res), do: res

  @doc """
  [P36] Lists all the prime factors of number with multiplicity

  ## Usage

      iex> import NinetyNine.Arithmetic
      iex> prime_factors_with_multiplicity(315)
      [[3,2],[5,1],[7,1]]
  """
  def prime_factors_with_multiplicity(1), do: [[1, 1]]

  def prime_factors_with_multiplicity(n) do
    n
    |> prime_factors()
    |> run_length_encoding()
    |> Enum.map(fn {i, j} -> [j, i] end)
  end

  @doc """
  [P37] Calculate Euler's totient function phi(m) (improved).

  ## Usage
    iex> import NinetyNine.Arithmetic
    iex> phi(11)
    10
    iex> phi(38)
    18
  """
  def phi(n) do
    n
    |> prime_factors_with_multiplicity()
    |> Enum.map(fn [p, m] ->
      (p - 1) * pow(p, m - 1)
    end)
    |> Enum.reduce(&*/2)
  end

  @doc """
  [P38] Compare the two methods of calculating Euler's totient function.

  ## Tests
      iex> import NinetyNine.Arithmetic
      iex> 1..1000 |>
      ...> Enum.map(&phi_bench/1) |>
      ...> Enum.filter(fn {a, b} -> a > b end) |>
      ...> Enum.all?()
      true
  """
  def phi_bench(n) do
    b_naive = NinetyNine.Benchmark.measure(&naive_phi/1, [n])
    b_improved = NinetyNine.Benchmark.measure(&phi/1, [n])

    {b_naive, b_improved}
  end
end
