require_relative '../lib/connect_four'

describe ConnectFour do
  describe '#print_board' do
    subject(:new_game) {described_class.new()}
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
  end
end
