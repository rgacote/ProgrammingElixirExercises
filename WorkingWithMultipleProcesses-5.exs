defmodule WorkingWithProcesses3 do
  @moduledoc """
  Use spawn_monitor to start a process.
  Have that process send a message to the parent and exit immediately.
  Have parent sleep for 1000ms then receive as many messages as are waiting.
  """

  @doc """
  Wait 1s before receiving anything.

  spawn_monitor allows us to receive exit messages.
  """
  def go do
    parent = self()
    spawn_monitor(WorkingWithProcesses3, :reply, [parent])

    :timer.sleep(1000)

    receive do
      {:DOWN, _ref, :process, _from_pid, reason} ->
        IO.puts("Exit reason: #{reason}")

      msg ->
        IO.puts("Received #{msg}")
    end
  end

  def reply(parent) do
    IO.puts("in reply")
    exit("Bye Bye")
  end
end

WorkingWithProcesses3.go()
