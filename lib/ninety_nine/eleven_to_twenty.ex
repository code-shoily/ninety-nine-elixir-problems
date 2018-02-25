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

  @doc """
  [P16] Drop every N'th element from a list.

  # Examples

      iex> NinetyNine.ElevenToTwenty.drop_every([:a, :b, :c, :d, :e, :f, :g, :h, :i, :k], 3)
      [:a, :b, :d, :e, :g, :h, :k]
  """
  def drop_every(lst, every), do: drop_every(lst, every, 1, [])
  def drop_every([], _, _, lst), do: lst

  def drop_every([_ | xs], every, ctr, lst) when rem(ctr, every) == 0 do
    drop_every(xs, every, ctr + 1, lst)
  end

  def drop_every([x | xs], every, ctr, lst) do
    drop_every(xs, every, ctr + 1, lst ++ [x])
  end

  @doc """
  [P17] Split a list into two parts; the length of the first part is given.

  ## Example
      
      iex> NinetyNine.ElevenToTwenty.split_at([:a, :b, :c, :d, :e, :f, :g, :h, :i, :k], 3)
      [[:a, :b, :c], [:d, :e, :f, :g, :h, :i, :k]]

      iex> NinetyNine.ElevenToTwenty.split_at([1,2,3], -1)
      [[1,2,3], []]

      iex> NinetyNine.ElevenToTwenty.split_at([1,2,3], 10)
      [[1,2,3], []]

  """
  def split_at([], _), do: [[], []]
  def split_at(lst, n) when n <= 0, do: [lst, []]
  def split_at(lst, n), do: split_at(lst, n, 0, [[], []])
  def split_at(_, n, ctr, res) when n <= ctr, do: res

  def split_at([x | xs], n, ctr, [lst, _]), do: split_at(xs, n, ctr + 1, [lst ++ [x], xs])
  def split_at([], _, _, res), do: res

  @doc """
  [P18] Extract a slice from a list.

  ## Examples

      iex> NinetyNine.ElevenToTwenty.slice([:a, :b, :c, :d, :e, :f, :g, :h, :i, :k], 3, 7)
      [:c, :d, :e, :f, :g]

      iex> NinetyNine.ElevenToTwenty.slice([1], 100, 100)
      []

      iex> NinetyNine.ElevenToTwenty.slice([1], 1, 1)
      [1]

      iex> NinetyNine.ElevenToTwenty.slice([1,2,3], -1, 2)
      [1, 2]

      iex> NinetyNine.ElevenToTwenty.slice([1,2,3], 100, 101)
      []

      iex> NinetyNine.ElevenToTwenty.slice([1,2,3], 200, 100)
      []
  """
  def slice(lst, from, to), do: slice(lst, from, to, 1, [])

  def slice(_, _, to, ctr, res) when ctr > to, do: res
  def slice([_ | xs], from, to, ctr, _) when ctr < from, do: slice(xs, from, to, ctr + 1, [])

  def slice([x | xs], from, to, ctr, res) when ctr >= from and ctr <= to,
    do: slice(xs, from, to, ctr + 1, res ++ [x])

  def slice([], _, _, _, _), do: []
end
