def translate (sentence)
	words = sentence.split(" ")
	words.each {|i| 
		if i[0] =~ /[aeiou]/
			i = i << "ay"
		else 
			if i[1] =~ /[aeiou]/ && i[0] != "q"
				front = i[0]
				i.delete! (front)
				i = i << front << "ay"
			else	
				if i[1] == "q" && i[2] == "u"
					front = i[0..2]
					i.delete! (front)
					i = i << front << "ay"
				elsif i[2] =~ /[aeiou]/
					front = i[0..1]
					i.delete! (front)
					i = i << front << "ay"
				else
					front = i[0..2]
					i.delete! (front)
					i = i << front << "ay"
				end
			end
		end
}
words.join(" ")
end
