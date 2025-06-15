require_relative '../lib/connect_four'

describe ConnectFour do
  subject(:new_game) {described_class.new()}

  describe '#print_board' do
    context 'when a new game has started' do
      it 'displays an empty board' do
        expected = \
          "|             |\n" + \
          "|             |\n" + \
          "|             |\n" + \
          "|             |\n" + \
          "|             |\n" + \
          "|             |\n" + \
          "|-------------|\n" + \
          "|1 2 3 4 5 6 7|"
        expect(new_game).to receive(:puts).with(expected)
        new_game.print_board
      end
    end

    context 'when player 1 places a token' do
      it 'gets added to the board' do
        expected = \
          "|             |\n" + \
          "|             |\n" + \
          "|             |\n" + \
          "|             |\n" + \
          "|             |\n" + \
          "|      o      |\n" + \
          "|-------------|\n" + \
          "|1 2 3 4 5 6 7|"
        expect(new_game).to receive(:puts).with(expected)
        new_game.place(1, 4)
        new_game.print_board
      end
    end

    context 'when player 2 places a token' do
      it 'appears ontop of player 1' do
        expected = \
          "|             |\n" + \
          "|             |\n" + \
          "|             |\n" + \
          "|             |\n" + \
          "|      x      |\n" + \
          "|      o      |\n" + \
          "|-------------|\n" + \
          "|1 2 3 4 5 6 7|"
        expect(new_game).to receive(:puts).with(expected)
        new_game.place(1, 4)
        new_game.place(2, 4)
        new_game.print_board
      end
    end

    context 'when player 2 places a token' do
      it 'appears beside player 1' do
        expected = \
          "|             |\n" + \
          "|             |\n" + \
          "|             |\n" + \
          "|             |\n" + \
          "|             |\n" + \
          "|      o x    |\n" + \
          "|-------------|\n" + \
          "|1 2 3 4 5 6 7|"
        expect(new_game).to receive(:puts).with(expected)
        new_game.place(1, 4)
        new_game.place(2, 5)
        new_game.print_board
      end
    end
  end

  describe '#place' do
    context 'when placing a token outside the column' do
      it 'raises an IndexError' do
        expect{ new_game.place(1, 0) }.to raise_error(IndexError, "Column 0 is out of bounds")
        expect{ new_game.place(1, 10) }.to raise_error(IndexError, "Column 10 is out of bounds")
      end
    end

    context 'when placing a token in a full column' do
      it 'raises an IndexError' do
        6.times {
          expect{ new_game.place(1, 3) }.not_to raise_error
        }
        expect{ new_game.place(1, 3) }.to raise_error(IndexError, "Column 3 is full")
      end
    end
  end

  describe '#get_winner' do
    context 'when there is no winner' do
      it 'returns nil' do
        expect(new_game.get_winner).to be_nil

        3.times do |i|
          new_game.place(1, i + 1)
        end
        expect(new_game.get_winner).to be_nil

        3.times do
          new_game.place(2, 3)
        end
        expect(new_game.get_winner).to be_nil
      end
    end

    context 'when player 1 has a horizontal win' do
      it 'returns 1' do
        4.times do |i|
          new_game.place(1, i + 1)
        end
        expect(new_game.get_winner).to eq(1)
      end
    end

    context 'when player 2 has a vertical win' do
      it 'returns 2' do
        4.times do
          new_game.place(2, 3)
        end
        expect(new_game.get_winner).to eq(2)
      end
    end

    context 'when player 1 has a diagonal win' do
      it 'returns 1' do
        new_game.place(1, 1)
        new_game.place(2, 2)
        new_game.place(1, 2)
        new_game.place(2, 3)
        new_game.place(1, 4)
        new_game.place(2, 3)
        new_game.place(1, 3)
        new_game.place(2, 4)
        new_game.place(1, 5)
        new_game.place(2, 4)
        new_game.place(1, 4)
        expect(new_game.get_winner).to eq(1)
      end
    end
    
    context 'when player 2 has a diagonal win' do
      it 'returns 2' do
        new_game.place(2, 7)
        new_game.place(1, 6)
        new_game.place(2, 6)
        new_game.place(1, 5)
        new_game.place(2, 4)
        new_game.place(1, 5)
        new_game.place(2, 5)
        new_game.place(1, 4)
        new_game.place(2, 3)
        new_game.place(1, 4)
        new_game.place(2, 4)
        expect(new_game.get_winner).to eq(2)
      end
    end
  end

  describe '#player_input' do
    error_message = "Input error! Please enter a number between 1 and 7."

    context 'when player enters a valid number' do
      it 'stops loop and does not display error message' do
        valid_input = '3'
        allow(new_game).to receive(:gets).and_return(valid_input)
        expect(new_game).not_to receive(:puts).with(error_message)
        new_game.player_input()
      end
    end
    
    context 'when player enters two invalid numbers, then a valid number' do
      it 'stops loop and displays the error message twice' do
        invalid_1 = '12'
        invalid_2 = '%#'
        valid_input = '3'
        allow(new_game).to receive(:gets).and_return(invalid_1, invalid_2, valid_input)
        expect(new_game).to receive(:puts).with(error_message).twice
        new_game.player_input()
      end
    end
  end
end
