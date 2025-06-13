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
end
