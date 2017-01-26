require_relative "../chess.rb"

RSpec.describe Bishop do
  let(:game) {Game.new}
  let(:board) {game.empty_board}
  let(:e4) {board[35] = Bishop.new("white", "e4")}

  describe '#move' do
    it "moves diagonally one spaces" do
      e4.move(board, "f5")
      expect(board[44]).to_not eq(nil)
    end

    it "moves diagonally more than one space" do
      e4.move(board, "h7")
      expect(board[62].position).to eq("h7")
    end

    it "doesn't move in the column" do
      e4.move(board, "f4")
      expect(board[43]).to eq(nil)
    end

    it "doesn't move in the row" do
      e4.move(board, "e5")
      expect(board[36]).to eq(nil)
    end

    it "does't move if blocked by piece" do
      board[26] = Pawn.new("white", "d3")
      # e4.move(board, "c2")
      expect(e4.diagonally_blocked?(board, "c2")).to eq(true)
    end

    it "takes an opposite piece diagonally one space" do
      board[44] = Bishop.new("black", "f5")
      e4.move(board, "f5")
      expect(board[44].color).to eq("white")
    end

    it "takes an opposite piece diagonally multiple spaces" do
      board[62] = Bishop.new("black", "h7")
      e4.move(board, "h7")
      expect(board[62].color).to eq("white")
    end
  end
end
