defmodule Ticker03 do
  # 2 seconds
  @interval 2000
  @name :ticker

  def start do
    pid = spawn(__MODULE__, :generator, [[]])
    :global.register_name(@name, pid)
  end

  @doc """
  Multiple clients from the same node to can register.
  """
  def register(client_pid) do
    send(:global.whereis_name(@name), {:register, client_pid})
  end

  @doc """
  Send to each client in turn, not all at once.

  There is no mechanism for removing PIDs from clients list.
  Issue tick when wrapping to start of list.
  This is slightly different than the exercise which implied we never did a local tick.
  """
  def generator(clients, offset \\ 0) do
    IO.inspect(clients)

    receive do
      {:register, pid} ->
        IO.puts("registering #{inspect(pid)}")
        generator([pid | clients])
    after
      @interval ->
        client = Enum.at(clients, offset)

        if is_nil(client) do
          # We've run off the end of the list.
          IO.puts("tick")
          generator(clients, 0)
        else
          send(client, {:tick})

          # Calculate offset before tail recursion.
          offset = offset + 1
          generator(clients, offset)
        end
    end
  end
end

defmodule Client03 do
  def start do
    pid = spawn(__MODULE__, :receiver, [])
    Ticker03.register(pid)
  end

  def receiver do
    receive do
      {:tick} ->
        IO.puts("tock in client")
        receiver()
    end
  end
end

# iex --sname one
# c("nodes03.ex")
# Ticker03.start()

# iex --sname two
# c("nodes03.ex")
# Node.connect :"one@rgac-ms-2022"
# Client03.start()
