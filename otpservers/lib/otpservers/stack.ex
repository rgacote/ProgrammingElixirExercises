defmodule Stack do
  @moduledoc """
  Implement a LIFO stack.

  Return `nil` when empty.
  Implement an API that hides the GenServer call/cast complexity.
  """

  use GenServer

  # External API
  def start_link(stack) do
    GenServer.start_link(__MODULE__, stack, name: __MODULE__)
  end

  def pop do
    GenServer.call(__MODULE__, :pop)
  end

  def push(new_value) do
    GenServer.cast(__MODULE__, {:push, new_value})
  end

  # GenServer Implemenation
  def init(stack) do
    {:ok, stack}
  end

  def handle_call(:pop, _from, []) do
    {:reply, nil, []}
  end

  def handle_call(:pop, _from, stack) do
    {value, new_stack} = Stack.Impl.pop(stack)
    {:reply, value, new_stack}
  end

  def handle_cast({:push, new_value}, stack) do
    {:noreply, Stack.Impl.push(stack, new_value)}
  end
end

# { :ok, pid} = GenServer.start_link(Stack, [5, "cat", 9])
# GenServer.call(pid, :pop)
# GenServer.cast(pid, {:push, 42})
# Stack.start_link([5, "cat", 9])
# Stack.pop()
# Stack.push(42)
