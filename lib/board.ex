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
    {:ok, %{width: 10, height: 10, board: %{}}}
  end
  
  def handle_call({:paint_one_square, location, color}, _from, state) do
    %{board: board, width: width, height: height} = state
    board = put_in(board[location], color)
    state = %{board: board, width: width, height: height}

    {:reply, state, state}
  end
  
  def handle_call({:get_board}, _from, state) do
    {:reply, state, state}
  end
end
