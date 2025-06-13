
class ConnectFour
  def initialize
    @board = Array.new(6) { Array.new(7, :' ') }
  end

  def print_board
    board_display = '|'
    
    @board.each do |row|
      board_display += row.join(' ')
      board_display += "|\n|"
    end

    board_display += "-------------|\n|1 2 3 4 5 6 7|"
    puts board_display
  end

  def place(player, column)
    token = player == 1 ? :o : :x
    row = get_top_row(column - 1)
    @board[row][column - 1] = token
  end

  def get_top_row(column)
    if column < 0 or column >= @board[0].size
      raise IndexError, "Column #{column + 1} is out of bounds"
    end

    @board.each_with_index do |row, i|
      if row.fetch(column) != :' '
        if i == 0
          raise IndexError, "Column #{column + 1} is full"
        end
        return i - 1
      end
    end
    return @board.size - 1
  end
end
