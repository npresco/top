class Player

  def initialize(color)
    @color = color
  end

  # Player move
  #
  # @param {Array} - board
  # @param {String} - piece
  # @param {String} - move
  # @return {Array}
  def play(board, piece, move)
    piece_object = board[GRID[piece]]
    piece_object.move(board, move)
  end

end
