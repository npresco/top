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

  def row_blocked?(board, position)
    position_row = position[0]
    position_column = position[1].to_i
    if position_column > self.position_column
      board[(GRID[self.position] + 1)..(GRID[position] - 1)].any? {|c| c != nil}
    elsif self.position_column > position_column
      board[(GRID[position] + 1)..(GRID[self.position] - 1)].any? {|c| c != nil}
    end
  end

  def column_blocked?(board, position)
    position_row = position[0]
    position_column = position[1]
    column_array = []
    if position_row > self.position_row
      column_array =
      (self.position_row.next..(position_row.ord - 1).chr).to_a.map {|x| x + position_column}
    elsif position_row < self.position_row
      column_array =
      (position_row.next..(self.position_row.ord - 1).chr).to_a.map {|x| x + position_column}
    end
    column_pieces = []
    column_array.each do |c|
      column_pieces << board[GRID[c]]
    end
    column_pieces.any? {|c| c != nil}
  end

  def diagonally_blocked?(board, position)
    position_row = position[0]
    position_column = position[1].to_i
    diag = (1...(position_column - self.position_column).abs).to_a
    diag_array = []
    diag_pieces = []
    if position_row > self.position_row
      if position_column > self.position_column
        diag.each do |c|
          diag_array <<
            (self.position_row.ord + c).chr + (self.position_column + c).to_s
        end
      elsif position_column < self.position_column
        diag.each do |c|
          diag_array <<
            (self.position_row.ord + c).chr + (self.position_column - c).to_s
        end
      end
    elsif position_row < self.position_row
      if position_column > self.position_column
        diag.each do |c|
          diag_array <<
            (self.position_row.ord - c).chr + (self.position_column + c).to_s
        end
      elsif position_column < self.position_column
        diag.each do |c|
          diag_array <<
            (self.position_row.ord - c).chr + (self.position_column - c).to_s
        end
      end
    end
    diag_array.each do |c|
      diag_pieces << board[GRID[c]]
    end
    diag_pieces.any? {|c| c != nil}
  end

end
