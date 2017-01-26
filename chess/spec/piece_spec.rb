require_relative "../chess.rb"

RSpec.describe Piece do
  let(:game) {Game.new}
  let(:board) {game.empty_board}
  let(:b1) {board[8] = Pawn.new("white", "b1")}
  let(:e4) {board[35] = Rook.new("white", "e4")}

  describe "#move" do
    it "moves the position of the piece" do
      b1.move(board, "c1")
      expect(board[16].position).to_not eq(nil)
    end
  end

  describe "#row_blocked?" do
    it "returns true if piece is inbetween or on move" do
      board[38] = Rook.new("white", "e7")
      expect(e4.row_blocked?(board, "e8")).to eq(true)
    end

    it "returns false if a move to the right is clear" do
      expect(e4.row_blocked?(board, "e8")).to eq(false)
    end

    it "returns false if a move to the left is clear" do
      expect(e4.row_blocked?(board, "e1")).to eq(false)
    end
  end

  describe "#column_blocked?" do
    it "returns true if piece is inbetween or on move" do
      board[11] = Rook.new("white", "b4")
      expect(e4.column_blocked?(board, "a4")).to eq(true)
    end

    it "returns false if the move is clear" do
      expect(e4.column_blocked?(board, "a4")).to eq(false)
    end
  end
end
