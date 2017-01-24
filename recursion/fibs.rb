def fibs(n)
  if n == 0
  	array = [0]
  elsif n == 1
  	array = [0, 1]
  else
    i = 0
    j = 1
    count = 1
    array = [0, 1]
    while count != n
      k = i + j
      i = j
      j = k
      count += 1
      array.push(k)
    end
  end
  array * " "
end