defmodule BettyFred do
  @moduledoc """
  Write a program that spawns two processes and then passes each a unique token ("fred" and "betty").
  Have them send the tokens back.
  """
  @tokens [:fred, :betty]

  def go do
    for token <- @tokens do
      pid = spawn(BettyFred, :catcher, [])
      send(pid, token)
    end
  end

  def catcher do
    receive do
      token ->
        IO.puts("Received #{inspect(token)}")
    end
  end
end

BettyFred.go()
