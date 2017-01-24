def substrings(sentence, array)
  substrings = {}
  sentence.downcase!
  array.each {|x|
  substrings[sentence.scan(x)] = sentence.scan(x).length}
  substrings.each {|k,v| k = k.uniq! }
  substrings.delete_if {|k,v| k == []}
end
