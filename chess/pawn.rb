class Pawn < Piece
  attr_reader :unicode

  alias_method :super_move, :move

  def initialize(color, position)
    super(color, position)
    if self.color == "white"
      @unicode = "♙"
    elsif self.color == "black"
      @unicode = "♟"
    end
  end

  # Piece move
  #
  # @param {Array} - board
  # @param {String} - position
  # @return {Array}
  def move(board, position)
    if self.color == "white"
      white_move(board, position)
    elsif self.color == "black"
      black_move(board, position)
    end
  end

  # Piece move
  #
  # @param {Array} - board
  # @param {String} - position
  # @return {Array}
  def black_move(board, position)
    position_row = position[0]
    position_column = position[1].to_i
    if position_row == (self.position_row.ord - 1).chr && !board[GRID[position]]
      super_move(board, position)
    elsif position_row == (self.position_row.ord - 1).chr &&
          (position_column == self.position_column - 1 ||
           position_column == self.position_column + 1) &&
           board[GRID[position]].color &&
           board[GRID[position]].color != self.color
      super_move(board, position)
    else
      board
    end
  end

  # Piece move
  #
  # @param {Array} - board
  # @param {String} - position
  # @return {Array}
  def white_move(board, position)
    position_row = position[0]
    position_column = position[1].to_i
    if position_row == self.position_row.next &&
       position_column == self.position_column && !board[GRID[position]]
      super_move(board, position)
    elsif position_row == self.position_row.next &&
          (position_column == self.position_column - 1 ||
           position_column == self.position_column + 1) &&
           board[GRID[position]] != nil &&
           board[GRID[position]].color != self.color
      super_move(board, position)
    else
      board
    end
  end

end
