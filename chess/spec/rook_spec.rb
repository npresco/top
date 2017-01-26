require_relative "../chess.rb"

RSpec.describe Rook do
  let(:game) {Game.new}
  let(:board) {game.empty_board}
  let(:e4) {board[35] = Rook.new("white", "e4")}

  describe "#move" do

    it "moves in the same column more than one space up" do
      e4.move(board, "h4")
      expect(board[59].position).to eq("h4")
    end

    it "moves in the same column more than one space down" do
      e4.move(board, "a4")
      expect(board[3].position).to eq("a4")
    end

    it "moves in the same row more than one space to the left" do
      e4.move(board, "e1")
      expect(board[32].position).to eq("e1")
    end

    it "moves in the same row more than one space to the right" do
      e4.move(board, "e8")
      expect(board[39].position).to eq("e8")
    end

    it "doesn't move diagonally" do
      e4.move(board, "f5")
      expect(board[44]).to eq(nil)
    end

    it "doesn't move past same pieces in a row" do
      board[36] = Rook.new("white", "e5")
      e4.move(board, "e6")
      expect(board[37]).to eq(nil)
    end

    it "doesn't move past same pieces in a column" do
      board[27] = Rook.new("white", "e5")
      e4.move(board, "c4")
      expect(board[19]).to eq(nil)
    end
  end
end
