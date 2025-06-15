
class ConnectFour
  attr_reader :board
  def initialize
    @board = Array.new(6) { Array.new(7, :' ') }
  end

  def print_board(board = @board)
    board_display = '|'
    
    board.each do |row|
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

  def get_winner
    h_winner = get_horizontal_winner
    return h_winner if h_winner
    v_winner = get_vertical_winner
    return v_winner if v_winner
    get_diagonal_winner
  end

  private

  def get_top_row(j)
    if j < 0 or j >= @board[0].size
      raise IndexError, "Column #{j + 1} is out of bounds"
    end

    @board.each_with_index do |row, i|
      if row.fetch(j) != :' '
        if i == 0
          raise IndexError, "Column #{j + 1} is full"
        end
        return i - 1
      end
    end
    @board.size - 1
  end

  def get_horizontal_winner(board = @board)
    board.each do |row|
      row.each_cons(4) do |cons|
        return 1 if cons.all? { |token| token.to_sym == :o }
        return 2 if cons.all? { |token| token.to_sym == :x }
      end
    end
    nil
  end

  def get_vertical_winner(board = @board)
    get_horizontal_winner board.transpose
  end

  def get_diagonal_winner(board = @board)
    down_winner = get_down_diagonal_winner board
    return down_winner if down_winner
    get_up_diagonal_winner board
  end

  def get_down_diagonal_winner(board = @board)
    diag_board = []

    (board.size - 1).downto 0 do |i|
      length = board.size - i
      row = (0...length).collect do |t|
        board[t + i][t]
      end
      row = (0...length).collect { |t| board[t + i][t] }
      diag_board.append(row)
      # diag_board.append(row.fill(:' ', row.size...board.size))
    end

    1.upto(board[0].size - 1) do |j|
      length = board.size - j + 1
      row = (0...length).collect { |t| board[t][t + j] }
      diag_board.append(row)
    end

    get_horizontal_winner diag_board
  end

  def get_up_diagonal_winner(board = @board)
    get_down_diagonal_winner board.map(&:reverse)
  end
end
