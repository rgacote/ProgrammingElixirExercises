defmodule Stack.Stash do
  use GenServer

  @me __MODULE__

  # API
  def start_link(stack) do
    GenServer.start_link(@me, stack, name: @me)
  end

  @doc """
  Retrieve currently stashed value.

  ## Examples
      iex> Stack.Stash.get()
      Application.get_env(:stack, :stack)
  """
  def get() do
    GenServer.call(@me, {:get})
  end

  @doc ~S"""
  Replace the current stashed value with new stack.

  ## Examples
      iex> Stack.Stash.update([42,24])
      ...> Stack.Stash.get()
      [42, 24]
  """
  def update(stack) do
    GenServer.cast(@me, {:update, stack})
  end

  # Implementation
  def init(stack) do
    {:ok, stack}
  end

  def handle_call({:get}, _from, stack) do
    {:reply, stack, stack}
  end

  def handle_cast({:update, stack}, _) do
    {:noreply, stack}
  end
end
