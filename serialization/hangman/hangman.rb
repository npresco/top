require "yaml"

class Hangman
  attr_accessor :secret_word, :board, :guess_count

  def initialize
  	  @secret_word = make_secret_word
  	  @board = make_board
      @guess_count = 0
  end

  def make_secret_word
    dictionary = File.readlines "5desk.txt" #Load in dictionary and take out leading spaces
    dictionary.map! do |word|
	  word.rstrip
    end

    hangman_dictionary = dictionary.select do |word| #Trim dictionary to words between 5-12 characters
      (word.length > 4) && (word.length < 13)
    end

    hangman_dictionary.sample #Choose a random word
  end

  def make_board
  	"_" * @secret_word.length
  end

  def guess_letter
    gallow(@guess_count) 
    puts "\n"
    puts "Choose a letter"
    choice = gets.chomp
    if choice == "SAVE"
      save_game
    elsif choice == "EXIT"
      puts "\n"
      abort("Goodbye")
      puts "\n"
    else
      @secret_word.split("").each_with_index do |letter, lindex|
        if letter == choice
          @board[lindex] = choice
        end
      end
    end
    @guess_count += 1 unless (@secret_word.include? (choice)) || (choice == "SAVE") || (choice == "EXIT")
  end 

  def guess_loop_until_win
    while @board != @secret_word && @guess_count < 7
      @board.each_char {|c| print c, ' '}
      puts "\n"
      guess_letter
    end
    if @guess_count < 7
      puts "Winner"
      puts @secret_word
      puts "\n"
    else
      puts "YOU LOSE"
      puts @secret_word
      puts "\n"
    end
  end

  def save_game 
  File.open("save.yaml", "w") {|file|
    file << YAML::dump(NEWGAME)
  }
  end

  def gallow(x)
    gallow_pictures =[%q{
      _______
      |      |
      | 
      |
      |
    __|__

    },

    %q{
      _______
      |      |
      |      O
      |
      |
    __|__

    },
    %q{
      _______
      |      |
      |      O
      |      |
      |
    __|__

    },
    %q{
      _______
      |      |
      |      O
      |      |
      |     /
    __|__

    },
    %q{
      _______
      |      |
      |      O
      |      |
      |     / \
    __|__

    },
    %q{
      _______
      |      |
      |     \O
      |      |
      |     / \
    __|__

    },
    %q{
      _______
      |      |
      |     \O/
      |      |
      |     / \
    __|__

    },
    %q{
      _______
      |      |
      |     \X/
      |      |
      |     / \
    __|__

    }]
    puts gallow_pictures[x]
  end

end
rules = puts "Type 'SAVE' during play to save game and 'EXIT' to leave"
puts "Load Game (y/n)"
choice = gets.chomp
if choice == "y"
  if File.exist?("save.yaml")
    LOAD = YAML::load(File.open("save.yaml"))
    rules
    LOAD.guess_loop_until_win
  else
    NEWGAME = Hangman.new
    rules
    NEWGAME.guess_loop_until_win
  end
else
  NEWGAME = Hangman.new
  rules
  NEWGAME.guess_loop_until_win
end