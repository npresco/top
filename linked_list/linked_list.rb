require_relative "./node.rb"

# LinkedList class
class LinkedList
  attr_accessor :head, :tail

  def initialize
    @tail = Node.new(nil, nil)
    @head = Node.new(nil, @tail)
  end

  # adds a new node to the end of the list
  #
  # @param {Object, Integer, String} - value
  # @return {Node} - appended node
  def append(value)
    if @tail.value.nil?
      @tail.value = value
    else
      old_tail = @tail
      @tail = Node.new(value, nil)
      old_tail.next_node = @tail
    end
    @tail
  end

  # adds a new node to the start of the list
  #
  # @param {Object, Integer, String} - value
  # @return {Node} - prepended node
  def prepend(value)
    if @head.value.nil?
      @head.value = value
    else
      old_head = @head
      @head = Node.new(value, old_head)
    end
    @head
  end

  # adds a new node to the start of the list
  #
  # @return {Integer} - size of linked list
  def size
    count = 1
    node = @head
    count -= 1 if @head.value.nil?
    count -= 1 if @tail.value.nil?
    until node.next_node.nil?
      count += 1
      node = node.next_node
    end
    count
  end

  # returns the node at the given index starting at 0
  #
  # @param {Integer} - index
  # @return {Node} - node at passed index
  def at(index)
    return nil if index > size || size.zero?
    start = first_value
    while index > 0
      start = start.next_node
      index -= 1
    end
    start
  end

  # removes the last element from the list
  #
  # @return {Node} - last item of list that was removed
  def pop
    if size == 1
      old_tail = at(0)
      @tail = Node.new(nil, nil)
      @head = Node.new(nil, @tail)
    else
      old_tail = @tail
      new_last = at(size - 1)
      new_last.next_node = nil
    end
    old_tail
  end

  # returns true if the passed in value is in the list and
  # otherwise returns false.
  #
  # @param {Object, Integer, String} - data
  # @return {Boolean} - true if in the list/false if not
  def contains?(data)
    node = first_value
    return true if node.value == data
    until node.next_node.nil?
      return true if node.value == data
      node = node.next_node
    end
    return true if node.value == data
    false
  end

  # returns the index of the node containing data, or nil if not found.
  #
  # @param {Object, Integer, String} - data
  # @return {Integer} - index of node containing data
  def find(data)
    node = first_value
    count = 0
    return count if node.value == data
    until node.next_node.nil?
      return count if node.value == data
      node = node.next_node
      count += 1
    end
    return count if node.value == data
    nil
  end

  # represent your LinkedList objects as strings, so you can print them out
  # and preview them in the console. The format should be:
  # ( data ) -> ( data ) -> ( data ) -> nil
  #
  # @return {String} - linked list as ( data ) -> ( data ) -> ( data ) -> nil
  def to_s
    node = first_value
    string = ""
    return "( ) -> nil" if node.value.nil? && node.next_node.nil?
    string += "( #{node.value} ) -> "
    until node.next_node.nil?
      node = node.next_node
      string += "( #{node.value} ) -> "
    end
    string += "nil"
    string
  end

  # inserts the data at the given index
  #
  # @param {Object, Integer, String} - data
  # @param {Integer} - index
  # @return {Node} - inserted Node
  def insert_at(data, index)
    return nil if index < 0 || index > size
    old_node = at(index)
    node_before_old_node = at(index - 1)
    if index.zero?
      prepend(data)
    elsif index == size
      append(data)
    else
      node_before_old_node.next_node = Node.new(data, old_node)
    end
  end

  # remove_at(index) that removes the node at the given index.
  #
  # @param {Integer} - index
  # @return {Node} - removed Node
  def remove_at(index)
    return nil if index < 0 || index > size
    old_node = at(index)
    node_before = at(index - 1)
    node_after = at(index + 1)
    if index.zero?
      if @head.value.nil?
        @head.next_node = at(index + 1)
      else
        @head = at(index + 1)
      end
    elsif index == size
      pop
    else
      node_before.next_node = node_after
    end
    old_node
  end

  private

  # returns the first node in the list (has a value)
  #
  # @return {Node} - first node in list
  def first_value
    if @head.value.nil?
      @head.next_node
    else
      @head
    end
  end
end
