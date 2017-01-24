def merge_sort(a)
	m = a.length.to_f
	if m > 1
		half = (m/2)
		b = a.slice(0..half-1)
		c = a.slice((half)..m)

		merge_sort(b)
		merge_sort(c)

		a_i = 0
		b_i = 0
		c_i = 0

		while (b_i <= b.length) && (c_i <= c.length)
			if c[c_i].nil?	
					a[a_i] = b[b_i]
				  b_i += 1
			elsif b[b_i].nil?
					a[a_i] = c[c_i]
				  c_i += 1
			else
				if (b[b_i] <= c[c_i]) 
				  a[a_i] = b[b_i]
				  b_i += 1
				else
				  a[a_i] = c[c_i]
				  c_i += 1
				end
			end
			a_i += 1
		end
		if b_i == b.length + 1
		a[a_i..(b.length + c.length)] = c[c_i..c.length]
		else
		a[a_i..(b.length + c.length)] = b[b_i..b.length]
		end
	end
	a.compact
end
