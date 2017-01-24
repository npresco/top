class Player
	attr_accessor :name, :piece
end

class Board
	attr_accessor :s, :gamespace

	def initialize
		@s = [1,2,3,4,5,6,7,8,9]
		@gamespace = "\n\n\n\n\n\n #{@s[0]} | #{@s[1]} | #{@s[2]} \n___ ___ ___\n\n #{@s[3]} | #{@s[4]} | #{@s[5]} \n___ ___ ___\n\n #{@s[6]} | #{@s[7]} | #{@s[8]} \n\n\n\n\n\n"
	end

	def gamespace
		@gamespace = "\n\n\n\n\n\n #{@s[0]} | #{@s[1]} | #{@s[2]} \n___ ___ ___\n\n #{@s[3]} | #{@s[4]} | #{@s[5]} \n___ ___ ___\n\n #{@s[6]} | #{@s[7]} | #{@s[8]} \n\n\n\n\n\n"
	end

    def put_piece(selection, player)
      self.s = self.s.join.gsub!(/#{selection}/, player)
      self.s = self.s.split("")
      self.gamespace
      puts self.gamespace
    end
end

class TTT
	attr_accessor :player1, :player2, :board

	def initialize
	  @player1 = Player.new
      @player2 = Player.new
	  @board = Board.new
	end

	@@pieces = ["X", "O"]
	@@count = 1
	@@winner = 0
	@@choices = (1..9).to_a
	@@choice_counter = 0

	def setup(player)
	  puts "Player #{@@count}, what is your name?"
	  player.name = gets.chomp
	  pick_piece(player)
	  @@count += 1
	end

    def pick_piece(player)
      puts "#{player.name}, please select: #{@@pieces[0]}  #{@@pieces[1]}"
      player.piece = gets.chomp.upcase
      unless (player.piece == @@pieces[0]) || (player.piece == @@pieces[1])
      	pick_piece(player)
      end
      @@pieces.delete(player.piece)
    end

    def play
      players = [player1, player2]
          players.each {|player|
          puts board.gamespace
    	  good_choice(player)
    	  board.put_piece(@choice, player.piece)
    	  win?(player)
    	  if @@winner == 1
    	  	break
    	  elsif @@choice_counter == 9
    	  	break
    	  end
    	}
    end

    def good_choice(player)
      @@choice_counter += 1
      puts "#{player.name} choose a space: #{board.s.join(" ")}"
      @choice = gets.chomp.to_i
      @@choices.any? {|x| x == @choice} ? @choice : good_choice(player)
      @@choices.delete(@choice)
    end


    def win?(player)
	a = board.s
	c = [player.piece, player.piece, player.piece]
	  if ([a[0], a[3], a[6]] == c) || ([a[1], a[4], a[7]] == c) || ([a[2], a[5], a[8]] == c) || (a[0..2] == c) || (a[3..5] == c) || (a[6..8] == c) || ([a[0], a[4], a[8]] == c) || ([a[2], a[4], a[6]] == c)
		@@winner =+ 1
	  end
	end

	def play_loop_until_win
	  while @@winner == 0
	  	play
	  end
	end
end


game = TTT.new
game.setup(game.player1)
game.setup(game.player2)
game.play_loop_until_win