class Space
	attr_accessor :row, :column

	def initialize(row, column)
		@row = row
		@column = column
	end
end

class Knight
	attr_accessor :space, :from, :moves

	def initialize(space = nil, from = nil)
		@space = space
		@from = from
	end

end

def moves_maker(starting_space)
	movement = [[-2,-1],[-2,1],[2,-1],[2,1],[-1,-2],[-1,2],[1,-2],[1,2]]
	allowed = []
	movement.each {|x,y| allowed << [x+starting_space[0],y+starting_space[1]]}
	allowed.reject! {|x,y| (x > 7) || (x < 0) || (y > 7) || (y < 0)}
	allowed
end

def knight_moves(starting_space, ending_space)
	knight = Knight.new(starting_space)
	movement_queue = []
	checked = [starting_space]
	solution = []
	while knight.space != ending_space
		moves_maker(knight.space).each { |move|
			unless checked.include?(move)
				checked << knight
				movement_queue << Knight.new(move, knight)
			end
		}
		knight = movement_queue.shift
	end
	solution << knight.space
	until knight.from.nil?
		solution << knight.from.space
		knight = knight.from
	end
	solution.reverse.each {|move| p move}
end
