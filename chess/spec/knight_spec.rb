require_relative "../chess.rb"

RSpec.describe Knight do
  let(:game) {Game.new}
  let(:board) {game.empty_board}
  let(:e4) {board[35] = Knight.new("white", "e4")}

  describe "#move" do
    it "moves 2 spaces in column and 1 in row" do
      e4.move(board, "g5")
      expect(board[52].position).to eq("g5")
    end

    it "moves over pieces" do
      board[43] = Pawn.new("white", "f4")
      board[51] = Pawn.new("black", "g4")
      e4.move(board, "g5")
      expect(board[52].position).to eq("g5")
    end

    it "takes a piece of the opposite color" do
      board[52] = Pawn.new("black", "g5")
      e4.move(board, "g5")
      expect(board[52].color).to eq("white")
    end

    it "doesn't take a piece of the same color" do
      board[52] = Pawn.new("white", "g5")
      e4.move(board, "g5")
      expect(board[35].color).to eq("white")
    end
  end
end
