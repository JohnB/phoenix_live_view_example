defmodule DemoWeb.CollaborativeCanvasLive do
  use Phoenix.LiveView
  import Calendar.Strftime

  def render(assigns) do
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
          <td id="01" phx-click="paint-one-cell_01" class="<%= @colors["01"] %>">
          </td>
          <td id="02" phx-click="paint-one-cell_02" class="<%= @colors["02"] %>">
          </td>
          <td id="03" phx-click="paint-one-cell_03" class="<%= @colors["03"] %>">
          </td>
          <td id="04" phx-click="paint-one-cell_04" class="<%= @colors["04"] %>">
          </td>
        </tr>
        <tr>
          <td id="05" phx-click="paint-one-cell_05" class="<%= @colors["05"] %>">
          </td>
          <td id="06" phx-click="paint-one-cell_06" class="<%= @colors["06"] %>">
          </td>
          <td id="07" phx-click="paint-one-cell_07" class="<%= @colors["07"] %>">
          </td>
          <td id="08" phx-click="paint-one-cell_08" class="<%= @colors["08"] %>">
          </td>
        </tr>
        <tr>
          <td id="09" phx-click="paint-one-cell_09" class="<%= @colors["09"] %>">
          </td>
          <td id="10" phx-click="paint-one-cell_10" class="<%= @colors["10"] %>">
          </td>
          <td id="11" phx-click="paint-one-cell_11" class="<%= @colors["11"] %>">
          </td>
          <td id="12" phx-click="paint-one-cell_12" class="<%= @colors["12"] %>">
          </td>
        </tr>
        <tr>
          <td id="13" phx-click="paint-one-cell_13" class="<%= @colors["13"] %>">
          </td>
          <td id="14" phx-click="paint-one-cell_14" class="<%= @colors["14"] %>">
          </td>
          <td id="15" phx-click="paint-one-cell_15" class="<%= @colors["15"] %>">
          </td>
          <td id="16" phx-click="paint-one-cell_16" class="<%= @colors["16"] %>">
          </td>
        </tr>
      <tbody>
    </table>
    """
  end

  def mount(_session, socket) do
    {:ok, assign(socket,
      paint: "blue",
      colors: %{},
      selected: %{"blue" => "selected"}
      )}
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

  def handle_event("paint-one-cell_" <> id, _, socket) do
    %{paint: paint, colors: colors} = socket.assigns
    colors = put_in(colors[id], paint)
    
    new_socket =
      socket
      |> assign(colors: colors)
    {:noreply, new_socket}
  end
end
