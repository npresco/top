class King < Piece
  attr_reader :unicode

  def initialize(color, position)
    super(color, position)
    if self.color == "white"
      @unicode = "♔"
    elsif self.color == "black"
      @unicode = "♚"
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
    if ((position_row == self.position_row.next ||
        position_row == (self.position_row.ord - 1).chr) &&
       position_column == self.position_column &&
       !self.column_blocked?(board, position) &&
       !board[GRID[position]]) ||
       (position_row == self.position_row &&
       (position_column == (self.position_column + 1) ||
       position_column == (self.position_column - 1)) &&
       !self.row_blocked?(board, position) &&
       !board[GRID[position]])
      super(board, position)
    elsif ((position_row == self.position_row.next ||
          position_row == (self.position_row.ord - 1).chr) &&
          position_column == self.position_column &&
          !self.column_blocked?(board, position) &&
          board[GRID[position]].color != self.color) ||
          (position_row == self.position_row &&
          (position_column == (self.position_column + 1) ||
          position_column == (self.position_column - 1)) &&
          !self.row_blocked?(board, position) &&
          board[GRID[position]].color != self.color)
      super(board, position)
    elsif ((position_row.ord - self.position_row.ord).abs ==
       (position_column - self.position_column).abs) &&
       (position_row.ord - self.position_row.ord).abs == 1 &&
       !self.diagonally_blocked?(board, position) &&
       !board[GRID[position]]
      super(board, position)
    elsif ((position_row.ord - self.position_row.ord).abs ==
          (position_column - self.position_column).abs) &&
          (position_row.ord - self.position_row.ord).abs == 1 &&
          !self.diagonally_blocked?(board, position) &&
          board[GRID[position]].color != self.color
      super(board, position)
    else
      board
    end
  end

end
