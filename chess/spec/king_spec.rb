require_relative "../chess.rb"

RSpec.describe King do
  let(:game) {Game.new}
  let(:board) {game.empty_board}
  let(:e4) {board[35] = King.new("white", "e4")}

  describe "#move" do
    it "moves one space in a column" do
      e4.move(board, "f4")
      expect(board[43].position).to eq("f4")
    end

    it "doesn't move more than space in a column" do
      e4.move(board, "g4")
      expect(board[51]).to eq(nil)
    end

    it "moves one space in a row" do
      e4.move(board, "e5")
      expect(board[36].position).to eq("e5")
    end

    it "doesn't move more than space in a row" do
      e4.move(board, "e6")
      expect(board[37]).to eq(nil)
    end

    it "moves one space diagonally" do
      e4.move(board, "f5")
      expect(board[44].position).to eq("f5")
    end

    it "doesn't move more than space diagonally" do
      e4.move(board, "g6")
      expect(board[53]).to eq(nil)
    end
  end
end
