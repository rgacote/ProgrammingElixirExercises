defmodule WorkingWithProcesses3 do
  @moduledoc """
  Use spawn_link to start a process.
  Have that process send a message to the parent and exit immediately.
  Have parent sleep for 1000ms then receive as many messages as are waiting.
  """

  @doc """
  Wait 1s before receiving anything.
  """
  def go do
    parent = self()
    spawn_link(WorkingWithProcesses3, :reply, [parent])

    :timer.sleep(1000)
    receive do
      msg -> IO.puts("Received #{msg}")
    end
  end

  def reply(parent) do
    IO.puts("in reply")
    send parent, "Hello, there."
  end
end

WorkingWithProcesses3.go()
