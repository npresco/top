class Mastermind
	attr_accessor :player, :board

	def initialize
	  @board = Board.new
	  @player = Player.new
	  @@exact = 0
	end

	def play
	  until @@exact == 4
		check_guess
	  end
	  puts "Win"
	  board.code.each {|j| print j.color.center(10)}
	end

	def check_guess
	  player.four_guesses
	  close = 0
	  @@exact = 0
	  k = [0,1,2,3]
	  p = []
	  player.player_guesses.each_with_index {|x, xindex| 
	  	board.code.each_with_index {|c, cindex|
	  	  if (c.color == x.color) && (xindex == cindex)
	  	    @@exact += 1
	  	    k.delete(cindex)
	  	    p << cindex
	  	    next  	  
	  	  end  	    	
	  	}
	  }
	  player.player_guesses.each_with_index {|x, xindex|
	  	if p.none? {|h| h.to_i == xindex}
	    	k.each {|l| if (board.code[l].color == x.color)
	    	  			  close += 1
	    	  			  k.delete(l)
	    				end
	    			}
	    end
	  }
	  puts "You have #{@@exact} exactly right"
	  puts "You have #{close} of the right color but wrong position"
	end

end

class Board
	attr_reader :code

	def initialize
	  pegs = Peg.new
	  @code = pegs.four_rand_pegs
	end

end

class Player
	attr_accessor :peg1, :peg2, :peg3, :peg4, :player_guesses

	def initialize
	  @peg1 = Peg.new
	  @peg2 = Peg.new
	  @peg3 = Peg.new
	  @peg4 = Peg.new
	end

	def guess(a)
	  a.choose_peg
	  a.color == @color
	end

	def four_guesses
	  @player_guesses = [self.peg1, self.peg2, self.peg3, self.peg4]
	  player_guesses.each {|x|
	    guess(x)
	  }
	  show_guess
	end

	def show_guess
	  print "\n\n\n"
	  @player_guesses = [self.peg1, self.peg2, self.peg3, self.peg4]
	  player_guesses.each {|x|
      print x.color.center(10)
	  }
	  print "\n\n\n"
	end

end

class Peg
	attr_accessor :color

	def initialize(color="blank")
		@color = color
	end

	@@colors = ["RED", "GREEN", "YELLOW", "BLUE", "MAGENTA", "CYAN"]

	def choose_peg
	  puts "Choose a color #{@@colors}"
	  chosen_peg = gets.chomp.upcase
	  if @@colors.any? {|x| x == chosen_peg}
	  	@color = chosen_peg
	  else
	  	choose_peg
	  end
	end

	def four_rand_pegs
	  # colors = ["\e[41m  \e[0m", "\e[42m  \e[0m", "\e[43m  \e[0m", "\e[44m  \e[0m", "\e[45m  \e[0m", "\e[46m  \e[0m"]
	  four = []
	  ["a","b","c","d"].each {|x|
	  x = Peg.new(@@colors.sample)
	  four << x
	  }
	  four
	end

end

puts "\n\n\n\n\nGuess the computer's code \nThe code is a sequence of 4 that can be 6 different colors\n\n\n"
game = Mastermind.new
game.play