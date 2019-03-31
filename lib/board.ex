defmodule Board do
  use GenServer
  
  # Client
  # The 10x10 board starts out empty
  
  def start_link() do
    case GenServer.start_link(__MODULE__, %{}, name: {:global, __MODULE__}) do
      {:ok, pid} -> {:ok, pid}
      {:error, {:already_started, pid}} -> {:ok, pid}
    end
  end
  
  def board() do
    {:ok, pid} = start_link()
    GenServer.call(pid, {:get_board})
  end
  
  # Paint the specified square
  def paint_one_square(location, color) do
    {:ok, pid} = start_link()
    GenServer.call(pid, {:paint_one_square, location, color})
  end
  
  # Server
  def init(_init_arg) do
    # The bogus 12345 value will be fixed on the first 1-second update of the actual count.
    squares = Map.new((0..15), fn x -> {"#{x}", "red"} end)
#    IO.puts("Squares: #{inspect(squares)}")
    {:ok, %{width: 10, height: 10, board: squares, user_count: 12345, current_count: 0, reset_at: Time.utc_now}}
  end
  
  def handle_call({:paint_one_square, location, color}, _from, state) do
    %{board: board} = state
    board = put_in(board[location], color)
    state = Map.merge(state, %{board: board})

    {:reply, state, state}
  end
  
  def handle_call({:get_board}, _from, state) do
    current_count = state[:current_count]
    now = Time.utc_now
    
    # We expect callers to get the board every second, so if more than a second has elapsed,
    # update our user count and reset the time.
    if Time.diff(now, state[:reset_at]) > 0 do
      # NOTE: when running this code locally, the value of user_count is an off-by-one
      # too low - but seems to work fine on Heroku. So there is some bug - maybe it becomes
      # weirdly synchronous on localhost - or maybe wrong in both places but Heroku deployment
      # causes an offsetting bug (such as one rogue client which has been continuously connected).
      # (consider resetting the secret key, to kick such clients out)
      state = Map.merge(state, %{reset_at: now, user_count: current_count, current_count: 0})
      {:reply, state, state}
    else
      #IO.puts(inspect {"update", current_count, now})
      state = put_in(state[:current_count], current_count + 1)
      {:reply, state, state}
    end
  end
end
