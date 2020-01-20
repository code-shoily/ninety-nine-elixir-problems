defmodule NinetyNine.List do
  @moduledoc """
  Solve problems involving lists.
  """
  import NinetyNine.Utils.List

  @doc """
  [P01] Find the last element of a list.

  ## Examples

      iex> NinetyNine.List.last_element([1,2,3])
      3

      iex> NinetyNine.List.last_element([])
      nil

  """
  def last_element([]), do: nil
  def last_element([x]), do: x
  def last_element([_ | xs]), do: last_element(xs)

  @doc """
  [P02] Find the last but one element of a list.

  ## Examples

      iex> NinetyNine.List.last_but_one([0,1,2,3])
      2

      iex> NinetyNine.List.last_but_one([0])
      nil

      iex> NinetyNine.List.last_but_one([])
      nil

  """
  def last_but_one([x, _]), do: x
  def last_but_one([_, x | xs]), do: last_but_one([x | xs])
  def last_but_one(_), do: nil

  @doc """
  [P03] Find the K'th element of a list.

  ## Examples

      iex> NinetyNine.List.kth_element([1,2,3,4,5], 2)
      3

  """
  def kth_element(xs, idx), do: at(xs, idx)

  @doc """
  [P04] Find the number of elements of a list.

  ## Examples

      iex> NinetyNine.List.number_of_elements([])
      0

      iex> NinetyNine.List.number_of_elements([1,2,3])
      3

  """
  def number_of_elements(xs), do: len(xs)

  @doc """
  [P05] Reverse a list.

  ## Examples

      iex> NinetyNine.List.reverse_list([1,2,3])
      [3,2,1]

      iex> NinetyNine.List.reverse_list([1])
      [1]

      iex> NinetyNine.List.reverse_list([])
      []

  """
  def reverse_list(xs), do: reverse(xs)

  @doc """
  [P06] Find out whether a list is a palindrome.

  ## Examples

      iex> NinetyNine.List.palindrome?([1,2,3,4,5])
      false

      iex> NinetyNine.List.palindrome?([1,2,3,2,1])
      true

  """
  def palindrome?(xs), do: xs === reverse(xs)

  @doc """
  [P07] Transform a list, possibly holding lists as elements into
  a `flat' list by replacing each list with its elements (recursively).

  ## Examples

      iex> NinetyNine.List.flatten_list([[1,2], 3, 4])
      [1,2,3,4]

      iex> NinetyNine.List.flatten_list([1,2,3,4,[[6,7],8]])
      [1,2,3,4,6,7,8]

      iex> NinetyNine.List.flatten_list([1,[2, [3]]])
      [1,2,3]

      iex> NinetyNine.List.flatten_list([1,2,3,4,5])
      [1,2,3,4,5]
  """
  def flatten_list(xs), do: flatten(xs)

  @doc """
  [P08] Eliminate consecutive duplicates of list elements.

  ## Examples

      iex> NinetyNine.List.dup([1,1,1,2,3,3,4,4,4,1,1,2,3,3,5])
      [1,2,3,4,1,2,3,5]

      iex> NinetyNine.List.dup([1,2,2,3,4])
      [1,2,3,4]

      iex> NinetyNine.List.dup([1,2,3,4])
      [1,2,3,4]
  """
  def dup([]), do: []
  def dup([x1, x2 | xs]) when x1 == x2, do: dup([x1] ++ xs)
  def dup([x | xs]), do: [x] ++ dup(xs)

  @doc """
  [P09] Pack consecutive duplicates of list elements into sublists.

  ## Examples

      iex> NinetyNine.List.pack_repetitions([1,2,3,4])
      [[1], [2], [3], [4]]

      iex> NinetyNine.List.pack_repetitions([])
      []

      iex> NinetyNine.List.pack_repetitions([1,1,1,1,2,2,2,3,3,1,1,3,4,2])
      [[1,1,1,1],[2,2,2],[3,3],[1,1],[3],[4],[2]]
  """
  def pack_repetitions([]), do: []

  def pack_repetitions(xs) do
    [:end | xs]
    |> sublistify()
    |> Enum.reduce(&merge_if_equal(&1, &2))
    |> reverse()
    |> tl()
  end

  @doc """
  [P10] Run-length encoding of a list.

  ## Examples

      iex> NinetyNine.List.run_length_encoding([:a,:b,:c,:d])
      [{1, :a}, {1, :b}, {1, :c}, {1, :d}]

      iex> NinetyNine.List.run_length_encoding([])
      []

      iex> NinetyNine.List.run_length_encoding([:a,:a,:a,:a,:b,:b,:b,:c,:a])
      [{4,:a},{3,:b}, {1, :c}, {1, :a}]
  """
  def run_length_encoding(lst) do
    for [x | _] = xs <- lst |> pack_repetitions(), do: {len(xs), x}
  end

  @doc """
  [P11] Modified Run-length encoding of a list.

  ## Examples

      iex> NinetyNine.List.modified_run_length_encoding([:a,:b,:c,:d])
      [:a, :b, :c, :d]

      iex> NinetyNine.List.modified_run_length_encoding([])
      []

      iex> NinetyNine.List.modified_run_length_encoding([:a,:a,:a,:a,:b,:b,:b,:c,:a])
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

      iex> NinetyNine.List.run_length_decode([:a, :b, :c, :d])
      [:a, :b, :c, :d]

      iex> NinetyNine.List.run_length_decode([{4,:a},{3,:b}, :c, :a])
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

      iex> NinetyNine.List.direct_run_length_encoding([:a,:b,:c,:d])
      [:a, :b, :c, :d]

      iex> NinetyNine.List.direct_run_length_encoding([])
      []

      iex> NinetyNine.List.direct_run_length_encoding([:a,:a,:a,:a,:b,:b,:b,:c,:a])
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
  [P14] Duplicate the elements of a list.

  ## Examples

      iex> NinetyNine.List.duplicate([:a, :b, :c])
      [:a, :a, :b, :b, :c, :c]
  """
  def duplicate(lst) do
    lst
    |> Enum.map(&repeat(&1, 2))
    |> flatten()
  end

  @doc """
  [P15] Duplicate the elements of a list a given number of times.

  ## Example

    iex> NinetyNine.List.duplicate_n([:a, :b, :c], 3)
    [:a, :a, :a, :b, :b, :b, :c, :c, :c]

  """
  def duplicate_n(lst, n) do
    lst
    |> Enum.map(&repeat(&1, n))
    |> flatten()
  end

  @doc """
  [P16] Drop every N'th element from a list.

  # Examples

      iex> NinetyNine.List.drop_every([:a, :b, :c, :d, :e, :f, :g, :h, :i, :k], 3)
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

      iex> NinetyNine.List.split([:a, :b, :c, :d, :e, :f, :g, :h, :i, :k], 3)
      [[:a, :b, :c], [:d, :e, :f, :g, :h, :i, :k]]

      iex> NinetyNine.List.split([1,2,3], -1)
      [[1,2,3], []]

      iex> NinetyNine.List.split([1,2,3], 10)
      [[1,2,3], []]

  """
  def split(lst, n), do: split_at(lst, n)

  @doc """
  [P18] Extract a slice from a list.

  ## Examples

      iex> NinetyNine.List.slice([:a, :b, :c, :d, :e, :f, :g, :h, :i, :k], 3, 7)
      [:c, :d, :e, :f, :g]

      iex> NinetyNine.List.slice([1], 100, 100)
      []

      iex> NinetyNine.List.slice([1], 1, 1)
      [1]

      iex> NinetyNine.List.slice([1,2,3], -1, 2)
      [1, 2]

      iex> NinetyNine.List.slice([1,2,3], 100, 101)
      []

      iex> NinetyNine.List.slice([1,2,3], 200, 100)
      []
  """
  def slice(lst, from, to), do: slice(lst, from, to, 1, [])

  def slice(_, _, to, ctr, res) when ctr > to, do: res
  def slice([_ | xs], from, to, ctr, _) when ctr < from, do: slice(xs, from, to, ctr + 1, [])

  def slice([x | xs], from, to, ctr, res), do: slice(xs, from, to, ctr + 1, res ++ [x])

  def slice([], _, _, _, _), do: []

  @doc """
  [P19] Rotate a list N places to the left.

  ## Examples

      iex> NinetyNine.List.rotate([1,2,3,4,5,6,7,8], 0)
      [1,2,3,4,5,6,7,8]

      iex> NinetyNine.List.rotate([1,2,3,4,5,6,7,8], 5)
      [6,7,8,1,2,3,4,5]

      iex> NinetyNine.List.rotate([1,2,3,4,5,6,7,8], 3)
      [4,5,6,7,8,1,2,3]

      iex> NinetyNine.List.rotate([1,2,3,4,5,6,7,8], -2)
      [7,8,1,2,3,4,5,6]
  """
  def rotate(lst, n) when n > 0 do
    lst |> split_at(n) |> reverse() |> flatten()
  end

  def rotate(lst, n) when n < 0 do
    lst |> rotate(len(lst) + n)
  end

  def rotate(lst, n) when n == 0, do: lst

  @doc """
  [P20] Remove the K'th element from a list.

  ## Examples

      iex> NinetyNine.List.remove([1,2,3,4,5], 3)
      [1,2,4,5]

      iex> NinetyNine.List.remove([1,2,3,4,5], 1)
      [2,3,4,5]

      iex> NinetyNine.List.remove([1,2,3,4,5], 3)
      [1,2,4,5]
  """
  def remove(xs, n) do
    {_, res} = remove_at(xs, n)
    res
  end

  @doc """
  [P21] Insert an element at a given position into a list.

  ## Examples

      iex> NinetyNine.List.insert_at([1, 2, 3, 4, 5], 2, :x)
      [1, :x, 2, 3, 4, 5]

      iex> NinetyNine.List.insert_at([1, 2, 3, 4, 5], -1, :x)
      [1, 2, 3, 4, 5]

      iex> NinetyNine.List.insert_at([1, 2, 3, 4, 5], 100, :x)
      [1, 2, 3, 4, 5]
  """
  def insert_at(xs, pos, item), do: insert_at(xs, pos, item, 1, [])

  def insert_at([x | xs], pos, item, ctr, res) when pos != ctr,
    do: insert_at(xs, pos, item, ctr + 1, res ++ [x])

  def insert_at([x | xs], pos, item, ctr, res) when pos == ctr,
    do: insert_at(xs, pos, item, ctr + 1, res ++ [item] ++ [x])

  def insert_at([], _, _, _, res), do: res

  @doc """
  [P22] Create a list containing all integers within a given range.

  ## Examples

      iex> NinetyNine.List.consequetive_numbers(1, 1)
      [1]

      iex> NinetyNine.List.consequetive_numbers(1, 5)
      [1,2,3,4,5]

      iex> NinetyNine.List.consequetive_numbers(23, 21)
      [23, 22, 21]
  """
  def consequetive_numbers(a, b), do: range(a, b)

  @doc """
  [P23] Extract a given number of randomly selected elements from a list.

  ## Example

      iex> NinetyNine.List.random_selection([], 1)
      nil
      iex> lst = [112, 143, 165, 167]
      iex> res = NinetyNine.List.random_selection(lst, 2)
      iex> res |> Enum.map(&(&1 in lst)) |> Enum.all?
      true
      iex> Enum.count(res) == 2
      true

  """
  def random_selection(lst, n), do: random_selection(lst, len(lst), n, [])

  def random_selection(_, _, ctr, res) when ctr == 0, do: res
  def random_selection(_, 0, ctr, _) when ctr >= 0 or ctr < 0, do: nil

  def random_selection(lst, ln, ctr, res) do
    {x, remaining} = remove_at(lst, :rand.uniform(ln))
    random_selection(remaining, ln - 1, ctr - 1, res ++ [x])
  end

  @doc """
  [P24] Lotto: Draw N different random numbers from the set 1..M.

  ## Example

    iex> values = NinetyNine.List.lotto(49, 5)
    iex> length(values)
    5
    iex> Enum.all?(values, fn x -> x < 49 end)
    true
  """
  def lotto(to, n) do
    range(1, to)
    |> random_selection(n)
  end

  @doc """
  [P25] Generate a random permutation of the elements of a list.
  """
  def random_permutation(lst) do
    lst |> random_selection(len(lst))
  end

  @doc """
  [P26] TODO: Generate the combinations of K distinct objects chosen from the N elements of a list
  """
  def combination(_xs, _k) do
    raise "Not implemented"
  end

  @doc """
  [P27] TODO: Group the elements of a set into disjoint subsets.
  """
  def multinomial_coefficients(_lst, _mtx) do
    raise "Not implemented"
  end

  @doc """
  [P28] Sorting a list of lists according to length of sublists

  ## Examples
      iex> import NinetyNine.List
      NinetyNine.List
      iex> sublist_sort([])
      []
      iex> sublist_sort([[1,2,3]])
      [[1,2,3]]
      iex> sublist_sort([[1,2,3], [2], [1,2]])
      [[2], [1,2], [1,2,3]]
      iex> sublist_sort([1,2,3])
      :error
      iex> sublist_sort([[1,2],3,[4,5],[6]])
      :error
  """
  def sublist_sort([]), do: []
  def sublist_sort([_ | []] = lst), do: lst

  def sublist_sort([_ | _] = lst) do
    case len(lst) == lst |> Enum.filter(&is_list/1) |> len do
      true -> sort_by_length(lst)
      _ -> :error
    end
  end

  def sublist_sort(_), do: :error

  def sort_by_length([x | xs]) do
    x_len = len(x)

    smaller_than_x =
      xs
      |> Enum.filter(&(len(&1) <= x_len))
      |> sublist_sort()

    larger_than_x =
      xs
      |> Enum.filter(&(len(&1) > x_len))
      |> sublist_sort()

    smaller_than_x ++ [x] ++ larger_than_x
  end
end
