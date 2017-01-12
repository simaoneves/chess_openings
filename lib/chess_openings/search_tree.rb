require_relative 'chess_openings_helper.rb'

# Class that is a Tree-like data structure to hold all Openings
class SearchTree
  attr_accessor :root

  def initialize
    @root = Node.new(nil)
  end

  # Check if tree doesnt have child Nodes and root is empty
  #
  # @return [Boolean] True if the tree doesnt have childs and root value is nil, false otherwise
  def empty?
    @root.empty? && @root.leaf?
  end

  # Number of not empty Nodes
  #
  # @return [int] Total of not empty Nodes in the tree
  def size
    size_helper(@root)
  end

  # String representation of the tree
  #
  # @return [String] Representation of the Nodes in the tree
  def to_s
    @root.to_s
  end

  # Compares two trees
  #
  # @param [SearchTree] other SearchTree to be compared with
  # @return [Boolean] True if both trees have the same children with the same values
  def ==(other)
    @root == other.root
  end

  # Insert new value in SearchTree at the depth of the moves
  #
  # @param [Array] moves Path to the place to insert the value
  # @param [Opening] value Value to be inserted in the tree
  def insert(moves, value)
    moves = ChessOpeningsHelper.moves_as_symbols(moves)
    insert_helper(moves, value, @root)
  end

  # Search in the tree with the path moves
  #
  # @param [Array] moves Array with Strings or symbols that represent the path
  # @return [Opening] Opening that was found in the tree, Nil otherwise
  def search(moves)
    moves = ChessOpeningsHelper.moves_as_symbols(moves)
    search_helper(moves, @root)
  end

  # Search the tree for all the values from the path and values of its children
  #
  # @param [Array] moves Array with Strings or symbols that represent the path
  # @return [Array] Array with values found
  def search_all_with_moves(moves)
    moves = ChessOpeningsHelper.moves_as_symbols(moves)
    node = find_node(moves, @root)
    get_all_from_node(node).flatten
  end

  # Get all values at a certain depth
  #
  # @param [int] num Depth to be used to find values
  # @return [Array] Array with all the values found at depth num
  def get_moves_in_depth(num)
    get_moves_in_depth_helper(num, @root, 0).flatten
  end

  private

  def get_moves_in_depth_helper(num_moves, curr_node, depth)
    return [] if depth == num_moves && curr_node.value.nil?
    return [curr_node.value] if depth == num_moves
    result = []
    curr_node.nodes.values.each do |node|
      result << get_moves_in_depth_helper(num_moves, node, depth + 1)
    end
    result
  end

  def find_node(moves, curr_node)
    return curr_node if moves.empty?

    curr_hash = curr_node.nodes
    move = moves.first
    return nil if curr_hash[move].nil?

    next_node = curr_hash[move]
    find_node(moves.drop(1), next_node)
  end

  def get_all_from_node(curr_node)
    result = curr_node.value.nil? ? [] : [curr_node.value]
    return result if curr_node.leaf?

    curr_hash = curr_node.nodes
    curr_hash.values.each do |next_node|
      result << get_all_from_node(next_node)
    end

    result
  end

  def insert_helper(moves, value, curr_node)
    return if moves.empty?
    curr_hash = curr_node.nodes
    move = moves.first
    last_move = moves.size == 1
    if curr_hash[move].nil?
      curr_hash[move] = last_move ? Node.new(value) : Node.new(nil)
    elsif last_move && curr_hash[move].value.nil?
      curr_hash[move].value = value
    end
    insert_helper(moves.drop(1), value, curr_hash[move])
  end

  def search_helper(moves, curr_node)
    move = moves.first
    curr_hash = curr_node.nodes
    return nil if curr_hash[move].nil?
    next_node = curr_hash[move]
    search_helper(moves.drop(1), next_node) || curr_hash[move].value
  end

  def size_helper(node)
    sum = node.value.nil? ? 0 : 1
    return sum if node.leaf?
    node.keys.each do |key|
      sum += size_helper(node.nodes[key])
    end
    sum
  end

  # Class that represents a node of a tree data structure
  class Node
    attr_accessor :value, :nodes

    def initialize(value)
      @value = value
      @nodes = {}
    end

    def empty?
      @value.nil?
    end

    def leaf?
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
      return false if size != other.size || @value != other.value
      @nodes.keys.each do |key|
        return false unless other.keys.include?(key)
        return false if @nodes[key] != other.nodes[key]
      end
      true
    end
  end
end
