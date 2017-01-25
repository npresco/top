class Piece
  attr_reader :color, :position_row, :position_column, :position

  def initialize(color, position)
    @color = color
    @position = position
    @position_row = position[0]
    @position_column = position[1].to_i
  end

  def position=(position)
    @position = position
    @position_row = position[0]
    @position_column = position[1].to_i
  end

  def move(board, position)
    position_row = position[0]
    position_column = position[1].to_i
    if position_column <= 8 && position_column >= 1 &&
       position_row <= "h" && position_row >= "a"
       old_position = self.position
       self.position = position
       board[GRID[old_position]] = nil
       board[GRID[position]] = self
       board
    end
  end

end
