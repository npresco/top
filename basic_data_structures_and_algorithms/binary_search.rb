class Node
	attr_accessor :value, :parent, :left_child, :right_child

	def initialize(value, parent=value, left_child=nil, right_child=nil)
		@value = value
		@parent = parent
		@left_child = left_child
		@right_child = right_child
	end

end

def link(root, number)
	if number < root.value
		if root.left_child == nil
			root.left_child = Node.new(number, root.value)
		else
			link(root.left_child, number)
		end
	else number > root.value
		if root.right_child == nil
			root.right_child = Node.new(number, root.value)
		else
			link(root.right_child, number)
		end
	end
end

def build_tree(array)
	array.shuffle!
	root = Node.new(array[0], "ROOT")
	array.each_with_index {|number, index|
		if index == 0
			next
		else	
			link(root, number)
		end
	}
	root
end

def breadth_first_search(number, node)
	start_time = Time.now
	array_queue = [node]
	while number != array_queue[0].value
		if !(array_queue[0].left_child.nil?) 
			array_queue << array_queue[0].left_child
		end
		if !(array_queue[0].right_child.nil?) 
			array_queue << array_queue[0].right_child
		end
		array_queue.shift
	end
	puts "Value: #{array_queue[0].value}"
	puts "Parent Node: #{array_queue[0].parent}"
	puts "#{(Time.now - start_time) * 1000000} ns"
end

def depth_first_search(number, node)
	start_time = Time.now
	array_stack = [node]
	array_checked = [node]
	while number != array_stack[-1].value
			left = array_stack[-1].left_child
			right = array_stack[-1].right_child
			array_stack.pop
			array_stack << left unless left.nil? || array_checked.include?(left)
			array_checked << left unless left.nil?
			array_stack << right unless right.nil? || array_checked.include?(right)
			array_checked << right unless right.nil?
	end
	puts "Value: #{array_stack[-1].value}"
	puts "Parent Node: #{array_stack[-1].parent}"
	puts "#{(Time.now - start_time) * 1000000} ns"
end

def dfs_rec(number, node)
	start_time = Time.now
	puts "Value: #{node.value}\nNode: #{node}\nParent Node: #{node.parent}\n#{(Time.now - start_time) * 1000000} ns" if number == node.value

	if number < node.value
		dfs_rec(number, node.left_child) unless node.left_child.nil?
	else number > node.value
		dfs_rec(number, node.right_child) unless node.right_child.nil?
	end
end
