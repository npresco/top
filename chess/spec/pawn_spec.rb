require_relative "../chess.rb"

RSpec.describe Pawn do
  let(:game) {Game.new}
  let(:board) {game.empty_board}
  let(:b1) {board[8] = Pawn.new("white", "b1")}

  describe "#move" do
    it "moves forward one space" do
      b1.move(board, "c1")
      expect(board[16].position).to eq("c1")
    end

    it "can move two spaces on first move" do
      b1.move(board, "d1")
      expect(board[24].position).to eq("d1")
    end

    it "can't move two spaces on move other than first" do
      b1.move(board, "c1")
      board[16].move(board, "e1")
      expect(board[32]).to eq(nil)
    end

    it "doesn't move forward more than one space" do
      b1.move(board, "e1")
      expect(board[32]).to eq(nil)
    end

    it "doesn't move backwards" do
      b1.move(board, "a1")
      expect(board[0]).to eq(nil)
    end

    it "doesn't move forward if a piece is there" do
      board[16] = Pawn.new("white", "c1")
      b1.move(board, "c1")
      expect(board[8].position).to_not eq(nil)
    end

    it "takes the opposite piece diagonally" do
      board[17] = Pawn.new("black", "c2")
      b1.move(board, "c2")
      expect(board[17].color).to eq("white")
    end

    it "doesn't move diagonally without taking a piece" do
      b1.move(board, "c2")
      expect(board[17]).to eq(nil)
    end

    it "doesn't take the same color piece diagonally" do
      board[17] = Pawn.new("white", "c2")
      b1.move(board, "c2")
      expect(board[8].color).to eq("white")
    end
  end

end
