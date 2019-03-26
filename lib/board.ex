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
    {:ok, %{width: 10, height: 10, board: %{}, user_count: 0, current_count: 0, reset_at: Time.utc_now}}
  end
  
  def handle_call({:paint_one_square, location, color}, _from, state) do
    %{board: board} = state
    board = put_in(board[location], color)
    state = Map.merge(state, %{board: board})

    {:reply, state, state}
  end
  
  def handle_call({:get_board}, _from, state) do
    current_count = state[:current_count] + 1
    now = Time.utc_now
    
    # We expect callers to get the board every second, so if more than a second has elapsed,
    # update our user count and reset the time.
    if Time.diff(now, state[:reset_at]) > 0 do
      IO.puts(inspect {"reset", current_count, now})
      state = Map.merge(state, %{reset_at: now, user_count: current_count, current_count: 0})
      {:reply, state, state}
    else
      IO.puts(inspect {"update", current_count, now})
      state = put_in(state[:current_count], current_count)
      {:reply, state, state}
    end
  end
end
