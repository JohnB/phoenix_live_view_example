defmodule DemoWeb.Game do
  use Phoenix.LiveView

  def render(assigns) do
    ~L"""
      <table class="game-board">
        <tr>
          <td class="<%= @board["0"] %>"></td>
          <td class="<%= @board["1"] %>"></td>
          <td class="<%= @board["2"] %>"></td>
        </tr>
        <tr>
          <td class="<%= @board["3"] %>"></td>
          <td class="<%= @board["4"] %>"></td>
          <td class="<%= @board["5"] %>"></td>
        </tr>
        <tr>
          <td class="<%= @board["6"] %>"></td>
          <td class="<%= @board["7"] %>"></td>
          <td class="<%= @board["8"] %>"></td>
        </tr>
      </table>
    </div>
    """
  end

  def mount(_session, socket) do
    {:ok, assign(socket, board: %{
      "0" => "red",
      "4" => "blue",
    })}
  end
end
