defmodule(Stack.Impl) do
  @moduledoc """
  Implement stack details.
  """

  def pop([head | tail]) do
    {head, tail}
  end

  def push(stack, new_value) do
    [new_value | stack]
  end
end
