defmodule NinetyNineTest do
  use ExUnit.Case
  doctest NinetyNine.Utils
  doctest NinetyNine
  doctest NinetyNine.Twenty

  test "greets the world" do
    assert NinetyNine.hello() == :world
  end
end
