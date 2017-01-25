require_relative '../chess.rb'

RSpec.describe Piece do
  let(:game) {Game.new}
  let(:board) {game.board_array}
  let(:a1) {board[8]}

  describe '#move' do
    it 'moves the position of the piece' do
      a1.move(board, "c1")
      expect(board[16].position).to_not eq(nil)
    end
  end
end
