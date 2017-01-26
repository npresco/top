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


end
