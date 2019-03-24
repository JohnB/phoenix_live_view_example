defmodule DemoWeb.CollaborativeCanvasLive do
  use Phoenix.LiveView
  import Calendar.Strftime

  def render(assigns) do
    %{board: board, width: width, height: height} = assigns

    ~L"""
    <div class="color-picker">
      <button
        class="red <%= @selected["red"] %>"
        phx-click="set-color-red">
      </button>
      <button
        class="blue <%= @selected["blue"] %>"
        phx-click="set-color-blue">
      </button>
      <button
        class="green <%= @selected["green"] %>"
        phx-click="set-color-green">
      </button>
      <button
        class="yellow <%= @selected["yellow"] %>"
        phx-click="set-color-yellow">
      </button>
      <button
        class="orange <%= @selected["orange"] %>"
        phx-click="set-color-orange">
      </button>
      <button
        class="white <%= @selected["white"] %>"
        phx-click="set-color-white">
      </button>
    </div>
    <table class="board">
      <tbody>
        <tr>
        #{ Enum.map_join(1..height, "</tr><tr>", fn y -> "
          #{ Enum.map_join(1..width, fn x ->
            "<td phx-click="paint-one-cell_#{x},#{y}" class="<%= @board["#{x},#{y}"] %>">
             </td>" end) }
        " end) }
        </tr>
      <tbody>
    </table>
    """
  end

  def mount(_session, socket) do
    # Refresh the client periodically, to keep up with other painters.
    if connected?(socket), do: :timer.send_interval( 10_000, self(), :tick)
    # Force a refresh just before heroku would drop the connection.
#    if connected?(socket), do: :timer.send_interval( 49_500, self(), :heroku_hickup)

    %{board: board, width: width, height: height} = Board.board()
    {:ok, assign(socket,
      paint: "blue",
      width: width,
      height: height,
      board: board,
      selected: %{"blue" => "selected"}
    )}
  end
  
  def handle_info(:tick, socket) do
    %{board: board} = Board.board()
    {:noreply, assign(socket, board: board)}
  end

  # Our socket is continuing to send and receive JSON data
  # while people are on the page, but Heroku's servers are
  # looking for HTTP *connections*
  # to decide whether to drop the connection - and we lose
  # collaborative updates when that happens, so we'd rather
  # force an immediate reconnect when *we* choose.
  def handle_info(:heroku_hickup, socket) do
    render(socket.assigns)
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
  def handle_event("set-color-orange", _, socket) do
    {:noreply, assign(socket, paint: "orange", selected: %{"orange" => "selected"})}
  end
  def handle_event("set-color-white", _, socket) do
    {:noreply, assign(socket, paint: "white", selected: %{"white" => "selected"})}
  end

  def handle_event("paint-one-cell_" <> location, _, socket) do
    %{paint: paint} = socket.assigns
    %{board: board} = Board.paint_one_square(location, paint)
    
    {:noreply, assign(socket, board: board)}
  end
end
