class Knight < Piece
  attr_reader :unicode

  def initialize(color, position)
    super(color, position)
    if self.color == "white"
      @unicode = "♘"
    elsif self.color == "black"
      @unicode = "♞"
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
    if (self.position_row.ord - position_row.ord).abs == 1 &&
       (self.position_column - position_column).abs == 2 &&
       !board[GRID[position]] ||
       (self.position_row.ord - position_row.ord).abs == 2 &&
       (self.position_column - position_column).abs == 1 &&
       !board[GRID[position]]
       super(board, position)
    elsif (self.position_row.ord - position_row.ord).abs == 1 &&
          (self.position_column - position_column).abs == 2 &&
          board[GRID[position]].color != self.color ||
          (self.position_row.ord - position_row.ord).abs == 2 &&
          (self.position_column - position_column).abs == 1 &&
          board[GRID[position]].color != self.color
       super(board, position)
     else
       board
     end
  end


end
