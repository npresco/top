def stock_picker(stocks)
  n = stocks.length
  stockgain = {}
  stocks.each do |x| 
  	y = stocks.index(x) + 1
  	while y != n
  	  stockgain[[stocks.index(x),y]] = stocks[y] - x
  	  y += 1
    end
  end
  p stockgain.max_by {|k,v| v}[0]
end
