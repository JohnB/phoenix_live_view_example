defmodule DemoWeb.Game do
  use Phoenix.LiveView
  alias TilingGame.Pentomino
  alias TilingGame.Rack

  def render(assigns) do
    ~L"""
      <table class="game-board">
        <%= for y <- 0..19 do %>
          <tr>
          <%= for x <- 0..19 do %>
            <td class="<%= @board[Integer.to_string(20 * y + x)] %>"></td>
          <% end %>
          </tr>
        <% end %>
      </table>
      
      <table class="rack rack-left">
        <%= for y <- 0..(Rack.height-1) do %>
          <tr>
          <%= for x <- 0..(Rack.width-1) do %>
            <td class="<%= @racks["0"][Integer.to_string(Rack.width * y + x)] %>"></td>
          <% end %>
          </tr>
        <% end %>
      </table>
      <table class="rack">
        <%= for y <- 0..(Rack.height-1) do %>
          <tr>
          <%= for x <- 0..(Rack.width-1) do %>
            <td class="<%= @racks["1"][Integer.to_string(Rack.width * y + x)] %>"></td>
          <% end %>
          </tr>
        <% end %>
      </table>
      <table class="rack rack-left">
        <%= for y <- 0..(Rack.height-1) do %>
          <tr>
          <%= for x <- 0..(Rack.width-1) do %>
            <td class="<%= @racks["2"][Integer.to_string(Rack.width * y + x)] %>"></td>
          <% end %>
          </tr>
        <% end %>
      </table>
      <table class="rack">
        <%= for y <- 0..(Rack.height-1) do %>
          <tr>
          <%= for x <- 0..(Rack.width-1) do %>
            <td class="<%= @racks["3"][Integer.to_string(Rack.width * y + x)] %>"></td>
          <% end %>
          </tr>
        <% end %>
      </table>
    """
  end

  def mount(_session, socket) do
    {:ok, pentomino} = Pentomino.piece(17)
    board = Pentomino.smear(pentomino, 20) |> Map.new(fn idx -> {Integer.to_string(idx), "green"} end)
    racks = %{
      "0" => Rack.initial_positions |> Map.new(fn idx -> {Integer.to_string(idx), "red"} end),
      "1" => Rack.initial_positions |> Map.new(fn idx -> {Integer.to_string(idx), "yellow"} end),
      "2" => Rack.initial_positions |> Map.new(fn idx -> {Integer.to_string(idx), "green"} end),
      "3" => Rack.initial_positions |> Map.new(fn idx -> {Integer.to_string(idx), "blue"} end)
    }

    {:ok, assign(socket, board: board, racks: racks)}
  end
end
