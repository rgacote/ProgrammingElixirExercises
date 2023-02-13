defmodule Stack do
  @docmodule """
  Implement a LIFO stack.

  Return `nil` when empty.
  """
  use GenServer

  def init(stack) do
    {:ok, stack}
  end

  def handle_call(:pop, _from, []) do
    {:reply, nil, []}
  end

  def handle_call(:pop, _from, [head | tail]) do
    {:reply, head, tail}
  end
end

# { :ok, pid} = GenServer.start_link(Stack, [5, "cat", 9])
# GenServer.call(pid, :pop)