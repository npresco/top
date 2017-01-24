class Timer
	def initialize
		@seconds = 0
	end

	def seconds=(num)
		@seconds = num
	end

	def seconds
		@seconds
	end

	def time_string
		@time = @seconds
		if @time == 0
			@time_string = "00:00:00"
		elsif @time < 60
			"00:00:#{@seconds}"
		elsif @time >= 60 && @time < 3600
			@min = (@time/60).floor
			@sec = @time - (60 * @min)
			if @min < 10
				if @sec < 10
					"00:0#{@min}:0#{@sec}"
				else
					"00:0#{@min}:#{@sec}"
				end
			else
				if @sec < 10
					"00:#{@min}:0#{@sec}"
				else
					"00:#{@min}:#{@sec}"
				end
			end
		else
			@hour = (@time/3600).floor
			@min = ((@time - (3600 * @hour))/60).floor
			@sec = @time - (3600 * @hour) - (60 * @min)
			if @hour < 10
				if @min < 10
					if @sec < 10
						"0#{@hour}:0#{@min}:0#{@sec}"
					else
						"0#{@hour}:0#{@min}:#{@sec}"
					end
				else
					if @sec < 10
						"0#{@hour}:#{@min}:0#{@sec}"
					else
						"0#{@hour}:#{@min}:#{@sec}"
					end
				end
			else
			 	if @min < 10
					if @sec < 10
						"#{@hour}:0#{@min}:0#{@sec}"
					else
						"#{@hour}:0#{@min}:#{@sec}"
					end
				else
					if @sec < 10
						"#{@hour}:#{@min}:0#{@sec}"
					else
						"#{@hour}:#{@min}:#{@sec}"
					end
				end
			end
		end 
	end
end