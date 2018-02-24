defmodule NinetyNine.ElevenToTwenty do
  import NinetyNine.Utils
  import NinetyNine.FirstTen, only: [run_length_encoding: 1, pack_repetitions: 1]

  @doc """
  [P11] Modified Run-length encoding of a list.

  ## Examples

      iex> NinetyNine.ElevenToTwenty.modified_run_length_encoding([:a,:b,:c,:d])
      [:a, :b, :c, :d]

      iex> NinetyNine.ElevenToTwenty.modified_run_length_encoding([])
      []

      iex> NinetyNine.ElevenToTwenty.modified_run_length_encoding([:a,:a,:a,:a,:b,:b,:b,:c,:a])
      [{4,:a},{3,:b}, :c, :a]
  """
  def modified_run_length_encoding(lst) do
    for {size, elem} = item <- lst |> run_length_encoding() do
      if size == 1, do: elem, else: item
    end
  end

  @doc """
  [P12] Decode a run-length encoded list.

  ## Examples

      iex> NinetyNine.ElevenToTwenty.run_length_decode([:a, :b, :c, :d])
      [:a, :b, :c, :d]

      iex> NinetyNine.ElevenToTwenty.run_length_decode([{4,:a},{3,:b}, :c, :a])
      [:a,:a,:a,:a,:b,:b,:b,:c,:a]
  """
  def run_length_decode(lst) do
    lst
    |> Enum.map(fn
      {length, value} -> repeat(value, length)
      value -> value
    end)
    |> flatten()
  end

  @doc """
  [P13] Run-length encoding of a list (direct solution).

  ## Examples

      iex> NinetyNine.ElevenToTwenty.direct_run_length_encoding([:a,:b,:c,:d])
      [:a, :b, :c, :d]

      iex> NinetyNine.ElevenToTwenty.direct_run_length_encoding([])
      []

      iex> NinetyNine.ElevenToTwenty.direct_run_length_encoding([:a,:a,:a,:a,:b,:b,:b,:c,:a])
      [{4,:a},{3,:b}, :c, :a]
  """
  def direct_run_length_encoding(lst) do
    for [x | _] = xs <- lst |> pack_repetitions() do
      length = len(xs)

      case length do
        1 -> x
        _ -> {length, x}
      end
    end
  end

  @doc """
  [P14] Duplicate the elements of a list a given number of times.

  ## Examples

      iex> NinetyNine.ElevenToTwenty.duplicate([:a, :b, :c])
      [:a, :a, :b, :b, :c, :c]
  """
  def duplicate(lst) do
    lst
    |> Enum.map(&repeat(&1, 2))
    |> flatten()
  end
end
