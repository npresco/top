def caesar_cipher(sentence, number=0)
  upcases = ("A".."Z").to_a
  downcases = ("a".."z").to_a

  downhash = Hash[("a".."z").to_a.zip((0..25).to_a)]
  uphash = Hash[("A".."Z").to_a.zip((0..25).to_a)]

  letters = sentence.split("")

  letters.map! do |x|
      if downhash.include? (x)
        x = downhash[x] + number
        while x > 25
      	  x -= 26
        end
        x = downcases[x]
      elsif uphash.include? (x)
      	x = uphash[x] + number
        while x > 25
      	  x -= 26
        end
        x = upcases[x]
      else
      	x = x
      end
  end
  p letters.join
end