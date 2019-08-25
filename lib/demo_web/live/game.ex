defmodule DemoWeb.Game do
  use Phoenix.LiveView
  alias TilingGame.Pentomino

  def render(assigns) do
    ~L"""
      <table class="game-board">
        <tr>
          <td class="<%= @board["0"] %>"></td>
          <td class="<%= @board["1"] %>"></td>
          <td class="<%= @board["2"] %>"></td>
          <td class="<%= @board["3"] %>"></td>
          <td class="<%= @board["4"] %>"></td>
        </tr>
        <tr>
          <td class="<%= @board["5"] %>"></td>
          <td class="<%= @board["6"] %>"></td>
          <td class="<%= @board["7"] %>"></td>
          <td class="<%= @board["8"] %>"></td>
          <td class="<%= @board["9"] %>"></td>
        </tr>
        <tr>
          <td class="<%= @board["10"] %>"></td>
          <td class="<%= @board["11"] %>"></td>
          <td class="<%= @board["12"] %>"></td>
          <td class="<%= @board["13"] %>"></td>
          <td class="<%= @board["14"] %>"></td>
        </tr>
        <tr>
          <td class="<%= @board["15"] %>"></td>
          <td class="<%= @board["16"] %>"></td>
          <td class="<%= @board["17"] %>"></td>
          <td class="<%= @board["18"] %>"></td>
          <td class="<%= @board["19"] %>"></td>
        </tr>
        <tr>
          <td class="<%= @board["20"] %>"></td>
          <td class="<%= @board["21"] %>"></td>
          <td class="<%= @board["22"] %>"></td>
          <td class="<%= @board["23"] %>"></td>
          <td class="<%= @board["24"] %>"></td>
        </tr>
      </table>
    </div>
    """
  end

  def mount(_session, socket) do
    {:ok, pentomino} = Pentomino.piece(17)
    board = pentomino |> Map.new(fn idx -> {Integer.to_string(idx), "green"} end)

    {:ok, assign(socket, board: board)}
  end
end
