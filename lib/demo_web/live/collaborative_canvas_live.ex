defmodule DemoWeb.CollaborativeCanvasLive do
  use Phoenix.LiveView
  import Calendar.Strftime

  def render(assigns) do
    #    DemoWeb.PageView.render("collaborative_canvas.html", assigns)
    
    board_array = Map.values(assigns[:board])
    static = header_with_user <> board_html
#    IO.puts("Static0: #{inspect static}")
    static = String.split(static, "SPLIT")
    dynamic = [assigns[:user_count]] ++ board_array
    [u_c, zero, one, _two | rest] = dynamic
    dynamic = [u_c, zero, one, "green" | rest]
    IO.puts("Static (#{Enum.count(static)}): #{inspect static}")
    IO.puts("Dynamic (#{Enum.count(dynamic)}): #{inspect dynamic}")
    
    rrrendered = %Phoenix.LiveView.Rendered{static: static, dynamic: dynamic}
#    IO.puts("inspect rrrendered")
    IO.puts(inspect rrrendered)
    rrrendered
  end
  
  def header_with_user do
    """
      <h2>Pixels with Frenemies!</h2>
      <p>Pick a Color - Paint a Pixel - Before Others Do!</p>
      <div class="color-picker">
          <button
                  class="red "
          phx-click="set-color-red">
          </button>
          <button
                  class="blue "
          phx-click="set-color-blue">
          </button>
          <button
                  class="green "
          phx-click="set-color-green">
          </button>
          <br/>
          <button
                  class="yellow "
          phx-click="set-color-yellow">
          </button>
          <button
                  class="orange "
          phx-click="set-color-orange">
          </button>
          <button
                  class="white "
          phx-click="set-color-white">
          </button>
          <br/>
          Users:SPLIT
      </div>
    """
  end

  def board_html do
    width = 4
    cells = Enum.map_join(0..15, fn x ->
      case Integer.mod(x, width) do
        0 -> """
              </tr><tr><td phx-click="paint-one-cell_#{x}" class=" SPLIT "></td>
             """
        _ -> """
              <td phx-click="paint-one-cell_#{x}" class=" SPLIT "></td>
             """
      end
    end)
#    IO.puts("inspect cells")
#    IO.puts(inspect cells)

    
    """
    </div>
    <table class="board">
      <tbody>
        <tr>
    """ <> cells <>
    """
        </tr>
      </tbody>
    </table>
    """
  end

  def mount(_session, socket) do
    # Refresh the client periodically, to keep up with other painters.
#    if connected?(socket), do: :timer.send_interval(  1_000, self(), :tick)

    %{board: board, width: width, height: height} = Board.board()
    {:ok, assign(socket,
      paint: "blue",
      width: width,
      height: height,
      board: board,
      user_count: 0,
      selected: %{"blue" => "selected"}
    )}
  end
  
  def handle_info(:tick, socket) do
    %{board: board, user_count: user_count} = Board.board()
    {:noreply, assign(socket, board: board, user_count: user_count)}
  end

  def handle_event("set-color-red", _, socket) do
    {:noreply, assign(socket, paint: "red", selected: %{"red" => "selected"})}
  end
  def handle_event("set-color-blue", _, socket) do
    {:noreply, assign(socket, paint: "blue", selected: %{"blue" => "selected"})}
  end
  def handle_event("set-color-green", _, socket) do
    {:noreply, assign(socket, paint: "green", selected: %{"green" => "selected"})}
  end
  def handle_event("set-color-yellow", _, socket) do
    {:noreply, assign(socket, paint: "yellow", selected: %{"yellow" => "selected"})}
  end
  def handle_event("set-color-purple", _, socket) do
    {:noreply, assign(socket, paint: "purple", selected: %{"purple" => "selected"})}
  end
  def handle_event("set-color-orange", _, socket) do
    {:noreply, assign(socket, paint: "orange", selected: %{"orange" => "selected"})}
  end
  def handle_event("set-color-white", _, socket) do
    {:noreply, assign(socket, paint: "white", selected: %{"white" => "selected"})}
  end

  def handle_event("paint-one-cell_" <> location, _, socket) do
    %{paint: paint} = socket.assigns
    %{board: board, user_count: user_count} = Board.paint_one_square(location, paint)
    {:noreply, assign(socket, board: board, user_count: user_count)}
  end
end
