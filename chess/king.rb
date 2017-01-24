class King < Piece

  def initialize(position_row = "a", position_column = 1)
    super(color, position_row, position_column)
    if self.color == "white"
      @unicode = "♕"
    elsif self.color == "black"
      @unicode = "♛"
    end
  end

end
