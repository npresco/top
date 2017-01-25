require_relative '../chess.rb'

RSpec.describe Pawn do
  let(:game) {Game.new}
  let(:board) {game.board_array}
  let(:b1) {board[8]}

  describe '#move' do
    it 'moves forward one space' do
      b1.move(board, "c1")
      expect(board[16].position).to_not eq(nil)
    end

    it "doesn't move forward if a piece is there" do
      board[16] = Pawn.new("white", "c1")
      b1.move(board, "c1")
      expect(board[8].position).to_not eq(nil)
    end

    it 'takes the opposite piece diagonally' do
      board[17] = Pawn.new("black", "c2")
      b1.move(board, "c2")
      expect(board[17].color).to eq("white")
    end

    it "doesn't take the same color piece diagonally" do
      board[17] = Pawn.new("white", "c2")
      b1.move(board, "c2")
      expect(board[8].color).to eq("white")
    end
  end

end
