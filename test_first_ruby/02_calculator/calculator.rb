def add(a,b)
 a+b
end

def subtract(a,b)
 a-b
end

def sum(array)
  array.inject(0) {|sum, i| sum + i }
end

def multiply(*a)
  a.inject {|sum,i| sum * i}
end

def power(a,b)
  a**b
end

def factorial(a)
  i = 1
  if a == 0
  	return 1
  else
    p = Array (0..a)
    p.inject {|sum, i| sum + i}
  end
end