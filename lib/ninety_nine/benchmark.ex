defmodule NinetyNine.Benchmark do
  def measure(function, args \\ []) do
    function
    |> :timer.tc(args)
    |> elem(0)
    |> Kernel./(1_000_000)
  end
end
