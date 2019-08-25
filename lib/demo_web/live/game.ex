defmodule DemoWeb.Game do
  use Phoenix.LiveView
  alias TilingGame.Pentomino

  def render(assigns) do
    ~L"""
      <table class="game-board">
        <%= for i <- 0..19 do %>
          <tr>
          <%= for j <- 0..19 do %>
            <td class="<%= @board[Integer.to_string(20 * i + j)] %>"></td>
          <% end %>
          </tr>
        <% end %>
      </table>
    </div>
    """
  end

  def mount(_session, socket) do
    {:ok, pentomino} = Pentomino.piece(17)
    board = Pentomino.smear(pentomino, 20) |> Map.new(fn idx -> {Integer.to_string(idx), "green"} end)

    {:ok, assign(socket, board: board)}
  end
end
