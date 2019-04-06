defmodule DemoWeb.CollaborativeCanvasLive do
  use Phoenix.LiveView
  import Calendar.Strftime

  def render(assigns) do
    DemoWeb.PageView.render("collaborative_canvas.html", assigns)
  end

  def mount(_session, socket) do
    # Refresh the client periodically, to keep up with other painters.
    if connected?(socket), do: :timer.send_interval(  1_000, self(), :tick)

    %{board: board, width: width, height: height} = Board.board()
    {:ok, assign(socket,
      paint: "blue",
      width: width,
      height: height,
      board: board,
      dots: 0,
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
    %{paint: paint, dots: dots} = socket.assigns
    %{board: board, user_count: user_count} = Board.paint_one_square(location, paint)
    {:noreply, assign(socket, board: board, user_count: user_count, dots: dots + 1)}
  end
end
