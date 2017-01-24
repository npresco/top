def bubble_sort(array)
  n = array.length
  n.times {
  i = 0
  while i < n -1
    if array[i] > array[i+1]
    	array[i], array[i+1] = array[i+1], array[i]
    end
    i += 1
  end
  }
  array
end


def bubble_sort_by(array)
  n = array.length
  n.times {
      array.each {|x| 
      z = array.index(x)
      unless z == n -1
        a = yield array[z..(z+1)]
          if a > 0
            array[z], array[(z+1)] = array[(z+1)], array[z]
          end
      end
    }
  }
  p array
end