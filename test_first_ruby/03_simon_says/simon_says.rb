def echo (word)
	word
end

def shout (word)
	word.upcase
end

def repeat (word, n=2)
	[word] * n * ' '
end

def start_of_word(word, n)
	word[0..(n-1)]
end

def first_word(sentence)
	sentence.split(" ")[0]
end

def titleize(sentence)
 	caps = sentence.capitalize.split(" ")
 	caps.map! {|i| 
 		if (i == "and") 
 			i = i 
 		elsif (i == "over")
 			i = i 
 		elsif (i == "the")
 			i
 		else 
 			i.capitalize 
 		end}
 	caps.join(" ")
end