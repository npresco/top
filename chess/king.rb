class King < Piece
  attr_reader :unicode
  attr_accessor :check

  def initialize(color, position)
    super(color, position)
    if self.color == "white"
      @unicode = "♔"
    elsif self.color == "black"
      @unicode = "♚"
    end
    @check = false
  end

  # Piece move
  #
  # @param {Array} - board
  # @param {String} - position
  # @return {Array}
  def move(board, position)
    position_row = position[0]
    position_column = position[1].to_i
    original = self.position.dup
    if ((position_row == self.position_row.next ||
        position_row == (self.position_row.ord - 1).chr) &&
       position_column == self.position_column &&
       !self.column_blocked?(board, position) &&
       !board[GRID[position]]) ||
       (position_row == self.position_row &&
       (position_column == (self.position_column + 1) ||
       position_column == (self.position_column - 1)) &&
       !self.row_blocked?(board, position) &&
       !board[GRID[position]] &&
       !self.check?(board, position))
      super(board, position)
    elsif ((position_row == self.position_row.next ||
          position_row == (self.position_row.ord - 1).chr) &&
          position_column == self.position_column &&
          !self.column_blocked?(board, position) &&
          board[GRID[position]] &&
          board[GRID[position]].color != self.color) ||
          (position_row == self.position_row &&
          (position_column == (self.position_column + 1) ||
          position_column == (self.position_column - 1)) &&
          !self.row_blocked?(board, position) &&
          board[GRID[position]] &&
          board[GRID[position]].color != self.color) &&
          !self.check?(board, position)
      super(board, position)
    elsif ((position_row.ord - self.position_row.ord).abs ==
          (position_column - self.position_column).abs) &&
          (position_row.ord - self.position_row.ord).abs == 1 &&
          !self.diagonally_blocked?(board, position) &&
          !board[GRID[position]] &&
          !self.check?(board, position)
        super(board, position)
    elsif ((position_row.ord - self.position_row.ord).abs ==
          (position_column - self.position_column).abs) &&
          (position_row.ord - self.position_row.ord).abs == 1 &&
          !self.diagonally_blocked?(board, position) &&
          board[GRID[position]].color != self.color &&
          !self.check?(board, position)
        super(board, position)
    else
      board
    end
  end

  # Creats array of all diagonals spots to the passed piece object
  #
  # @param {Object} - piece
  # @return {Array}
  def create_diagonals(position)
    pr = position[0]
    pc = position[1].to_i
    row_p = ((pr.ord + 1).chr.."h").to_a
    row_m = ("a"..(pr.ord - 1).chr).to_a.reverse!
    u_r = row_p.map.with_index {|x,i| x + (pc.to_i + i + 1).to_s}
    u_l = row_p.map.with_index {|x,i| x + (pc.to_i - i - 1).to_s}
    b_r = row_m.map.with_index {|x,i| x + (pc.to_i + i + 1).to_s}
    b_l = row_m.map.with_index {|x,i| x + (pc.to_i - i - 1).to_s}
    (u_r + u_l + b_r + b_l).sort.reject {|x| GRID[x] == nil }
  end

  # Creates array of all row to the passed piece object
  #
  # @param {Object} - piece
  # @return {Array}
  def create_row(position)
    pr = position[0]
    pc = position[1].to_i
    col_p = ((pc + 1)..8).to_a
    col_m = (1..(pc - 1)).to_a.reverse!
    r = col_p.map.with_index {|x,i| pr + x.to_s}
    l = col_m.map.with_index {|x,i| pr + x.to_s}
    (r + l).sort.reject {|x| GRID[x] == nil }
  end

  # Creates array of all column spots to the passed piece object
  #
  # @param {Object} - piece
  # @return {Array}
  def create_column(position)
    pr = position[0]
    pc = position[1].to_i
    row_p = ((pr.ord + 1).chr.."h").to_a
    row_m = ("a"..(pr.ord - 1).chr).to_a.reverse!
    u = row_p.map.with_index {|x,i| x + pc.to_s}
    d = row_m.map.with_index {|x,i| x + pc.to_s}
    (u + d).sort.reject {|x| GRID[x] == nil }
  end

  # Creates array of all spots that a knight can go to from the passed piece object
  #
  # @param {Object} - piece
  # @return {Array}
  def create_l_move(position)
    pr = position[0]
    pc = position[1].to_i
    [(pr.ord + 2).chr + (pc + 1).to_s,
    (pr.ord + 1).chr + (pc + 2).to_s,
    (pr.ord - 2).chr + (pc - 1).to_s,
    (pr.ord - 1).chr + (pc - 2).to_s,
    (pr.ord - 2).chr + (pc + 1).to_s,
    (pr.ord - 1).chr + (pc + 2).to_s,
    (pr.ord + 2).chr + (pc - 1).to_s,
    (pr.ord + 1).chr + (pc - 2).to_s].sort.reject {|x| GRID[x] == nil }
  end

  # Check if king is in check
  #
  # @param {Array} - board
  # @return {Bool}
  def check?(board, position)
   if self.l_attacked?(board, position)
     true
   elsif self.row_attacked?(board, position)
     true
   elsif self.column_attacked?(board, position)
     true
   elsif self.diagonally_attacked?(board, position)
     true
   elsif self.pawn_attacked?(board, position)
     true
   else
     false
   end
  end

  def row_attacked?(board, position)
   r_attacks = self.create_row(position).map {|x| board[GRID[x]]}
   r_attacks.any? do |x|
     if x.kind_of?(Rook) || x.kind_of?(Queen)
       !x.row_blocked?(board, position) && x.color != self.color
     end
   end
  end

  def column_attacked?(board, position)
   c_attacks = self.create_column(position).map {|x| board[GRID[x]]}
   c_attacks.any? do |x|
     if x.kind_of?(Rook) || x.kind_of?(Queen)
       !x.column_blocked?(board, position) && x.color != self.color
     end
   end
  end

  def diagonally_attacked?(board, position)
   d_attacks = self.create_diagonals(position).map {|x| board[GRID[x]]}
   d_attacks.any? do |x|
     if x.kind_of?(Bishop) || x.kind_of?(Queen)
       !x.diagonally_blocked?(board, position) && x.color != self.color
     end
   end
  end

  def l_attacked?(board, position)
   l_attacks = self.create_l_move(position).map {|x| board[GRID[x]]}
   l_attacks.any? do |x|
     x.kind_of?(Knight) && x.color != self.color
   end
  end

  def pawn_attacked?(board, position)
   pr = position[0]
   pc = position[1]
   p_attacks = []
   if self.color == "white"
     p_attacks = [pr.next + (pc.to_i - 1).to_s,
                  pr.next + (pc.to_i + 1).to_s]
   elsif self.color == "black"
     p_attacks = [(pr.ord - 1).ord + (pc.to_i - 1).to_s,
                  (pr.ord - 1).ord + (pc.to_i + 1).to_s]
   end
    p_attacks.reject! {|x| GRID[x] == nil }
    p_attacks.map! {|x| board[GRID[x]]}
    p_attacks.any? do |x|
      x.kind_of?(Pawn) && x.color != self.color
    end
  end

end
