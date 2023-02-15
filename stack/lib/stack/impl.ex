defmodule(Stack.Impl) do
  @moduledoc """
  Implement stack details.
  """

  @doc """
  Remove most recent value from stack.

  ## Examples

      iex>Stack.Impl.pop([1, 2, 3])
      {1, [2, 3]}

      iex>Stack.Impl.pop([])
      {nil, []}
  """
  def pop([head | tail]) do
    {head, tail}
  end

  def pop([]) do
    {nil, []}
  end

  @doc """
  Add new value to the head of the stack.

  ## Examples

      iex> Stack.Impl.push([], 3)
      [3]

      iex> Stack.Impl.push([1, 2, 3], 4)
      [4, 1, 2, 3]

  """
  def push(stack, new_value) do
    if new_value < 0 do
      IO.puts("Cannot push negative values.")
      System.halt(-3)
    end

    [new_value | stack]
  end
end
