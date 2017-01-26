class Bishop < Piece
  attr_reader :unicode

  def initialize(color, position)
    super(color, position)
    if self.color == "white"
      @unicode = "♗"
    elsif self.color == "black"
      @unicode = "♝"
    end
  end

  # Piece move
  #
  # @param {Array} - board
  # @param {String} - position
  # @return {Array}
  def move(board, position)
    position_row = position[0]
    position_column = position[1].to_i
    if ((position_row.ord - self.position_row.ord).abs ==
       (position_column - self.position_column).abs) && !board[GRID[position]]
      super(board, position)
    elsif ((position_row.ord - self.position_row.ord).abs ==
          (position_column - self.position_column).abs) &&
           board[GRID[position]].color != self.color
      super(board, position)
    else
      board
    end
  end

end
