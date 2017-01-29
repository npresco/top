require_relative "player.rb"
require_relative "piece.rb"
require_relative "pawn.rb"
require_relative "bishop.rb"
require_relative "rook.rb"
require_relative "knight.rb"
require_relative "king.rb"
require_relative "queen.rb"

GRID = {
  "a1" => 0,
  "a2" => 1,
  "a3" => 2,
  "a4" => 3,
  "a5" => 4,
  "a6" => 5,
  "a7" => 6,
  "a8" => 7,
  "b1" => 8,
  "b2" => 9,
  "b3" => 10,
  "b4" => 11,
  "b5" => 12,
  "b6" => 13,
  "b7" => 14,
  "b8" => 15,
  "c1" => 16,
  "c2" => 17,
  "c3" => 18,
  "c4" => 19,
  "c5" => 20,
  "c6" => 21,
  "c7" => 22,
  "c8" => 23,
  "d1" => 24,
  "d2" => 25,
  "d3" => 26,
  "d4" => 27,
  "d5" => 28,
  "d6" => 29,
  "d7" => 30,
  "d8" => 31,
  "e1" => 32,
  "e2" => 33,
  "e3" => 34,
  "e4" => 35,
  "e5" => 36,
  "e6" => 37,
  "e7" => 38,
  "e8" => 39,
  "f1" => 40,
  "f2" => 41,
  "f3" => 42,
  "f4" => 43,
  "f5" => 44,
  "f6" => 45,
  "f7" => 46,
  "f8" => 47,
  "g1" => 48,
  "g2" => 49,
  "g3" => 50,
  "g4" => 51,
  "g5" => 52,
  "g6" => 53,
  "g7" => 54,
  "g8" => 55,
  "h1" => 56,
  "h2" => 57,
  "h3" => 58,
  "h4" => 59,
  "h5" => 60,
  "h6" => 61,
  "h7" => 62,
  "h8" => 63
}.freeze

BOARD_POSITIONS =
{
  "a1" => 785,
  "a2" => 789,
  "a3" => 793,
  "a4" => 797,
  "a5" => 801,
  "a6" => 805,
  "a7" => 809,
  "a8" => 813,
  "b1" => 683,
  "b2" => 687,
  "b3" => 691,
  "b4" => 695,
  "b5" => 699,
  "b6" => 703,
  "b7" => 707,
  "b8" => 711,
  "c1" => 581,
  "c2" => 585,
  "c3" => 589,
  "c4" => 593,
  "c5" => 597,
  "c6" => 601,
  "c7" => 605,
  "c8" => 609,
  "d1" => 479,
  "d2" => 483,
  "d3" => 487,
  "d4" => 491,
  "d5" => 495,
  "d6" => 499,
  "d7" => 503,
  "d8" => 507,
  "e1" => 377,
  "e2" => 381,
  "e3" => 385,
  "e4" => 389,
  "e5" => 393,
  "e6" => 397,
  "e7" => 401,
  "e8" => 405,
  "f1" => 275,
  "f2" => 279,
  "f3" => 283,
  "f4" => 287,
  "f5" => 291,
  "f6" => 295,
  "f7" => 299,
  "f8" => 303,
  "g1" => 173,
  "g2" => 177,
  "g3" => 181,
  "g4" => 185,
  "g5" => 189,
  "g6" => 193,
  "g7" => 197,
  "g8" => 201,
  "h1" => 71,
  "h2" => 75,
  "h3" => 79,
  "h4" => 83,
  "h5" => 87,
  "h6" => 91,
  "h7" => 95,
  "h8" => 99
}.freeze

class Game
  attr_accessor :board_array, :empty_board, :board, :player_w, :player_b

  def initialize
    @board_array = []
    (1..64).each do |c|
      @board_array << nil
    end

    # For testing
    @empty_board = []
    (1..64).each do |c|
      @empty_board << nil
    end

    # Initilize Players
    @player_w = Player.new("white")
    @player_b = Player.new("black")

    # Initialize pawns
    (8..15).each do |c|
      @board_array[c] = Pawn.new('white', GRID.key(c))
    end

    (48..55).each do |c|
      @board_array[c] = Pawn.new('black', GRID.key(c))
    end

    # Initalize bishops
    [2, 5].each do |c|
      @board_array[c] = Bishop.new("white", GRID.key(c))
    end

    [58, 61].each do |c|
      @board_array[c] = Bishop.new("black", GRID.key(c))
    end

    # Initialize rooks
    [0, 7].each do |c|
      @board_array[c] = Rook.new("white", GRID.key(c))
    end

    [56, 63].each do |c|
      @board_array[c] = Rook.new("black", GRID.key(c))
    end

    # Initialize knights
    [1, 6].each do |c|
      @board_array[c] = Knight.new("white", GRID.key(c))
    end

    [57, 62].each do |c|
      @board_array[c] = Knight.new("black", GRID.key(c))
    end

    # Initialize queens
    @board_array[3] = Queen.new("white", GRID.key(3))
    @board_array[59] = Queen.new("black", GRID.key(59))

    # Initialize kings
    @board_array[4] = King.new("white", GRID.key(4))
    @board_array[60] = King.new("black", GRID.key(60))

    @board = "
                 ┌───┬───┬───┬───┬───┬───┬───┬───┐
              h  │   │   │   │   │   │   │   │   │
                 ├───┼───┼───┼───┼───┼───┼───┼───┤
              g  │   │   │   │   │   │   │   │   │
                 ├───┼───┼───┼───┼───┼───┼───┼───┤
              f  │   │   │   │   │   │   │   │   │
                 ├───┼───┼───┼───┼───┼───┼───┼───┤
              e  │   │   │   │   │   │   │   │   │
                 ├───┼───┼───┼───┼───┼───┼───┼───┤
              d  │   │   │   │   │   │   │   │   │
                 ├───┼───┼───┼───┼───┼───┼───┼───┤
              c  │   │   │   │   │   │   │   │   │
                 ├───┼───┼───┼───┼───┼───┼───┼───┤
              b  │   │   │   │   │   │   │   │   │
                 ├───┼───┼───┼───┼───┼───┼───┼───┤
              a  │   │   │   │   │   │   │   │   │
                 └───┴───┴───┴───┴───┴───┴───┴───┘
                   1   2   3   4   5   6   7   8
            "

      self.update_board
  end

  def update_board
    @board_array.each_with_index do |c, i|
      if c
        board[BOARD_POSITIONS[GRID.key(i)]] = board_array[i].unicode
      else
        board[BOARD_POSITIONS[GRID.key(i)]] = " "
      end
    end
  end

  def show_board
    puts self.board
  end

  def king_check
    kings = self.board_array.dup.keep_if {|x| x.kind_of? King}
    king_in_check = kings.any? {|x| x.check?(self.board_array, x.position)}
    if king_in_check
      puts "CHECK!"
    end
  end

  def king_checkmate
    kings = self.board_array.dup.keep_if {|x| x.kind_of? King}
    king_in_check = kings.any? {|x| x.checkmate?(self.board_array, x.position)}
    if king_in_check
      false
    else
      true
    end
  end

  def console_move(turn)
    puts "#{turn} piece: "
    piece = gets.chomp
    puts "#{turn} move: "
    move = gets.chomp
  end

  def play_loop
    turn = "white"
    self.show_board
    while self.king_checkmate
      start_board = self.board_array.dup
      if turn == "White"
        while self.board_array == start_board
          self.king_check
          self.console_move(turn)
          self.player_w.play(self.board_array, piece, move)
          self.update_board
          self.show_board
        end
        turn = "Black"
      elsif turn == "Black"
        while self.board_array == start_board
          self.king_check
          self.console_move(turn)
          self.player_b.play(self.board_array, piece, move)
          self.update_board
          self.show_board
        end
        turn = "White"
      end
    end
    puts "CHECKMATE"
  end
end
