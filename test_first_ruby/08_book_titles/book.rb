class Book
	
	def capit(word)
		if word != "and" && word != "in" && word != "the" && word != "of" && word != "a" && word != "an"
			word.capitalize
		else
			word
		end
	end

	def title=(new_title)
		words = new_title.split(" ")
		words[0].capitalize!
		words.map! {|i| capit(i)}
		@title = words.join(" ")
	end

	def title
		@title
	end
end
