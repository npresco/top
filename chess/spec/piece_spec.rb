require_relative "../chess.rb"

RSpec.describe Piece do
  let(:game) {Game.new}
  let(:board) {game.empty_board}
  let(:b1) {board[8] = Pawn.new("white", "b1")}
  let(:e4) {board[35] = Rook.new("white", "e4")}
  let(:e5) {board[36] = Bishop.new("white", "e5")}

  describe "#move" do
    it "moves the position of the piece" do
      b1.move(board, "c1")
      expect(board[16].position).to_not eq(nil)
    end
  end

  describe "#row_blocked?" do
    it "returns true if piece is inbetween move" do
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
    it "returns true if piece is inbetween move" do
      board[11] = Rook.new("white", "b4")
      expect(e4.column_blocked?(board, "a4")).to eq(true)
    end

    it "returns false if the move is clear" do
      expect(e4.column_blocked?(board, "a4")).to eq(false)
    end
  end

  describe "#diagonally_blocked?" do
    it "returns true if piece is inbetween move (up left)" do
      board[50] = Pawn.new("white", "g3")
      expect(e5.diagonally_blocked?(board, "h2")).to eq(true)
    end

    it "returns true if piece is inbetween move (up right)" do
      board[45] = Pawn.new("white", "f6")
      expect(e5.diagonally_blocked?(board, "h8")).to eq(true)
    end

    it "returns true if piece is inbetween move (bottom left)" do
      board[27] = Pawn.new("white", "d4")
      expect(e5.diagonally_blocked?(board, "a1")).to eq(true)
    end

    it "returns true if piece is inbetween move (bottom right)" do
      board[29] = Pawn.new("white", "d6")
      expect(e5.diagonally_blocked?(board, "b8")).to eq(true)
    end

    it "returns true if piece is inbetween move (up left single)" do
      board[43] = Pawn.new("white", "f4")
      expect(e5.diagonally_blocked?(board, "g3")).to eq(true)
    end

    it "returns false if single move (up left)" do
      expect(e5.diagonally_blocked?(board, "f4")).to eq(false)
    end

    it "returns false if move is clear (up left)" do
      expect(e5.diagonally_blocked?(board, "h2")).to eq(false)
    end

    it "returns false if move is clear (up right)" do
      expect(e5.diagonally_blocked?(board, "h8")).to eq(false)
    end

    it "returns false if move is clear (bottom left)" do
      expect(e5.diagonally_blocked?(board, "a1")).to eq(false)
    end

    it "returns false if move is clear (bottom right)" do
      expect(e5.diagonally_blocked?(board, "b8")).to eq(false)
    end
  end
end
