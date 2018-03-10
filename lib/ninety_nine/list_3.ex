defmodule NinetyNine.List3 do
  @moduledoc """
  Problems 21 ~ 28 Solved
  """
  import NinetyNine.ListUtils

  @doc """
  [P21] Insert an element at a given position into a list.

  ## Examples

      iex> NinetyNine.List3.insert_at([1, 2, 3, 4, 5], 2, :x)
      [1, :x, 2, 3, 4, 5]

      iex> NinetyNine.List3.insert_at([1, 2, 3, 4, 5], -1, :x)
      [1, 2, 3, 4, 5]

      iex> NinetyNine.List3.insert_at([1, 2, 3, 4, 5], 100, :x)
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

      iex> NinetyNine.List3.consequetive_numbers(1, 1)
      [1]

      iex> NinetyNine.List3.consequetive_numbers(1, 5)
      [1,2,3,4,5]

      iex> NinetyNine.List3.consequetive_numbers(23, 21)
      [23, 22, 21]
  """
  def consequetive_numbers(a, b), do: range(a, b)

  @doc """
  [P23] Extract a given number of randomly selected elements from a list.

  # Test!

      iex> NinetyNine.List3.random_selection([], 1)
      nil
      iex> lst = [112, 143, 165, 167]
      iex> res = NinetyNine.List3.random_selection(lst, 2)
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
    :implement_me
  end

  @doc """
  [P27] TODO: Group the elements of a set into disjoint subsets.
  """
  def multinomial_coefficients(_lst, _mtx) do
    :implement_me
  end

  @doc """
  [P28] Sorting a list of lists according to length of sublists

  ## Examples
      iex> import NinetyNine.List3
      NinetyNine.List3
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
