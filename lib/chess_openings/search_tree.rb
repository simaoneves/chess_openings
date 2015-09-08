class SearchTree

  attr_accessor :root

  def initialize
    @root = Node.new(nil)
  end

  def empty?
    @root.is_leaf?
  end

  def size
    size_helper(@root)
  end

  def to_s
    @root.to_s
  end

  def ==(other)
    return false unless @root.size == other.root.size
    
    @root.keys.each do |key|
      return false unless other.root.keys.include?(key)
    end

    @root.keys.each do |key|
      return false unless @root.nodes[key] == other.root.nodes[key]
    end

    true
  end

  def insert(moves, value)
    insert_helper(moves, value, @root)
  end

  def search(moves)
    search_helper(moves, @root)
  end

  def search_all_with_moves(moves)
    node = find_node(moves, @root)
    get_all_from_node(node).flatten
  end


  private

    def find_node(moves, curr_node)
      return if moves.empty?

      curr_hash = curr_node.nodes
      move = moves.first
      last = moves.size == 1

      return nil if curr_hash[move].nil?
      
      if last
        return curr_node
      else
        next_node = curr_hash[move]
        find_node(moves.drop(1), next_node)
      end
    end

    def get_all_from_node(curr_node)

      result = curr_node.value.nil? ? [] : [curr_node.value]
      return result if curr_node.is_leaf?

      curr_hash = curr_node.nodes

      curr_hash.each do |key, value|
        next_node = value
        result << get_all_from_node(next_node)
      end

      result
    end

    def insert_helper(moves, value, curr_node)
      return if moves.empty?

      curr_hash = curr_node.nodes
      move = moves.first
      last = moves.size == 1

      if curr_hash[move].nil?
        if last
          curr_hash[move] = Node.new(value)
        else
          curr_hash[move] = Node.new(nil)
        end
      else
        curr_hash[move].value = value if last && curr_hash[move].value.nil?
      end

      next_node = curr_hash[move]
      insert_helper(moves.drop(1), value, next_node)
    end

    def search_helper(moves, curr_node)
      move = moves.first
      curr_hash = curr_node.nodes

      return nil if curr_hash[move].nil?

      next_node = curr_hash[move]
      return search_helper(moves.drop(1), next_node) || curr_hash[move].value
    end

    def size_helper(node)
      sum = node.value.nil? ? 0 : 1
      return sum if node.is_leaf?
      node.keys.each do |key|
        sum += size_helper(node.nodes[key])
      end
      return sum
    end

  class Node

    attr_accessor :value, :nodes

    def initialize(value)
      @value = value
      @nodes = {}
    end

    def is_leaf?
      @nodes.empty?
    end

    def size
      @nodes.size
    end

    def keys
      @nodes.keys
    end

    def include?(key)
      @nodes.keys.include?(key)
    end

    def ==(other)
      return false if self.size != other.size || @value != other.value
      @nodes.keys.each do |key|
        return false unless other.keys.include?(key)
      end

      @nodes.keys.each do |key|
        return false if @nodes[key] != other.nodes[key]
      end

      true
    end
  end

end