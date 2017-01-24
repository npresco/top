module Enumerable
  def my_each
    i = 0
    while i < self.length
  	  yield self[i]
  	  i += 1
    end
    self
  end

  def my_each_with_index
    i = 0
    while i < self.length
      yield self[i], self.index(self[i])
      i += 1
    end
    self
  end

  def my_select
  	i = 0
  	interim = []
  	while i < self.length
  	  (yield self[i]) == true ? interim << self[i] : nil
  	  i += 1
  	end
  	interim
  end

  def my_all?
  	if block_given? == true
  	i = 0
  	  while i < self.length
  	    (yield self[i]) == true ? true : a = false
  	      if a == false
  	  	    return false
  	      end
  	    i += 1
  	    end
  	  true
  	else 
  	  true
  	end
  end

  def my_any?
  	if block_given? == true
  	  i = 0
  	  while i < self.length
  	    (yield self[i]) == true ? a = true : false
  	      if a == true
  	  	    return true
  	      end
  	    i += 1
  	    end
  	  false
  	else 
  	  true
  	end
  end

  def my_none?
  	if block_given? == true
  	  i = 0
  	  while i < self.length
  	    (yield self[i]) == true ? a = true : false
  	      if a == true
  	  	    return false
  	      end
  	    i += 1
  	    end
  	  true
  	else 
  	  if self.all? {|x| x == false}
  	  	true
  	  else
  	  	false
  	  end
  	end
  end

  def my_count(n = (n_set = true))
  	if block_given? == true
  	  i = 0
  	  count = 0
  	  while i < self.length
  	  	n = yield self[i]
  	  	p n
  	  	if n
  	  		count += 1
  	    end
  	    i +=1
  	  end
  	  count
  	else
  		if n_set
  		  self.length
  		else
  		  i = 0
  		  count = 0
  			while i < self.length
  			  if self [i] == n
  			  	count += 1
  			  end
  			  i += 1
  			end
  			count
  		end	
    end
  end

  def my_map(proc=(proc_set = true))
  	if proc_set == true
  	#   if block_given? == true
   #    	i = 0
   #      interim = []
   #        while i < self.length
   #          interim << (yield self[i])
   #        i += 1
   #    	  end
   #      interim
	  # else
	    self
      # end
    else 
      if block_given? == true
      	i = 0
        interima = []
          while i < self.length
            interima << (yield self[i])
          i += 1
      	  end
      end
        i = 0
        interim = []
          while i < self.length
            interim << (proc.call self[i])
          i += 1
      	  end
        p interim
        p interima
    end 
  end

  def my_inject(sum=(sum_set = true; self[0]))
  	i = 0
  	if sum_set
  	  while i < (self.length - 1)
	    sum = yield sum, self[i+1]
	    i += 1
	  end
	 sum
	else
      while i < (self.length)
		sum = yield sum, self[i]
		i += 1
      end
	sum
	end
  end


end

def multiple_els(array)
  array.my_inject {|sum,x| sum * x}
end