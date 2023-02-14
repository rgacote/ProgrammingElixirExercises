defmodule(Stack.Impl) do
  @moduledoc """
  Implement stack details.
  """

  def pop([head | tail]) do
    {head, tail}
  end

  def push(stack, new_value) do
    if new_value < 0 do
      IO.puts("Cannot push negative values.")
      System.halt(-3)
    end

    [new_value | stack]
  end
end
