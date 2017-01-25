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

    it 'moves diagonally more than one space' do
      e4.move(board, "h7")
      expect(board[62].position).to eq("h7")
    end

    it "doesn't move forward" do
      e4.move(board, "f5")
      expect(board[37]).to eq(nil)
    end

    it "takes an opposite piece diagonally" do
      board[44] = Bishop.new("black", "f5")
      e4.move(board, "f5")
      expect(board[44].color).to eq("white")
    end
  end
end
