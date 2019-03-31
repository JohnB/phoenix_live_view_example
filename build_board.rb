#!/usr/local/bin/ruby
#
# Build a 10x10 board for the coloring app
#
width = 10
height = 10

height.times do |y|
  puts "    <tr>"
  width.times do |x|
    spot = x + 10 * y
    puts "      <td phx-click='paint-one-cell_#{spot}' class='<%= @board[\"#{spot}\"] %>'></td>"
  end
  puts "    </tr>"
end
