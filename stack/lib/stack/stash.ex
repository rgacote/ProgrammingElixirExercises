defmodule Stack.Stash do
  use GenServer

  @me __MODULE__

  # API
  def start_link(stack) do
    GenServer.start_link(@me, stack, name: @me)
  end

  def get() do
    GenServer.call(@me, {:get})
  end

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
