require_relative "../chess.rb"

RSpec.describe Queen do
  let(:game) {Game.new}
  let(:board) {game.empty_board}
  let(:e4) {board[35] = Queen.new("white", "e4")}

  describe "#move" do
    it "moves in a column" do
      e4.move(board, "g4")
      expect(board[51].position).to eq("g4")
    end

    it "moves in a row" do
      e4.move(board, "e6")
      expect(board[37].position).to eq("e6")
    end

    it "moves diagonally" do
      e4.move(board, "g6")
      expect(board[53].position).to eq("g6")
    end
  end
end
