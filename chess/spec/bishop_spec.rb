require_relative '../chess.rb'

RSpec.describe Bishop do
  let(:game) {Game.new}
  let(:board) {game.empty_board}
  let(:e4) {board[35] = Bishop.new("white", "e4")}

  describe '#move' do
    it 'moves diagonally' do
      e4.move(board, "f5")
      expect(board[44]).to_not eq(nil)
    end

    it "doesn't move forward" do
      e4.move(board, "e6")
      expect(board[37]).to eq(nil)
    end
  end
end
