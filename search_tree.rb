require 'json'

class SearchTree

  attr_accessor :root

  def initialize
    @root = {}
  end

  def empty?
    return @root.empty?
  end

  def load_openings
    
    openings = JSON.load(File.open("openings.json"))["openings"]
    result = []

    openings.each do |op|
      result << Opening.new(op["name"], op["eco_code"], op["moves"])
    end

    result.sort! { |x, y| x.moves.size <=> y.moves.size }
    result.each do |op|
      insert op.moves, op
    end

  end

  def to_s
    @root.to_s
  end

  def insert(moves, value)

    if moves.is_a? Array

      curr_node = @root

      moves.each_with_index do |move, index|

        if curr_node[move].nil?
          if moves.size == (index + 1)
            curr_node[move] = Node.new(value)
          else
            curr_node[move] = Node.new(move)
            curr_node = curr_node[move].nodes
          end
        else
          curr_node = curr_node[move].nodes
        end

      end


    else
      @root[moves] = Node.new(value)
    end
    
  end

  def get(moves)
    if moves.is_a? Array

      curr_hash = @root
      curr_node = nil

      moves.each_with_index do |move, index|

        if curr_hash.keys.include?(move)
          curr_node = curr_hash[move]
          curr_hash = curr_hash[move].nodes
          return curr_node.value if curr_hash.empty? || moves.size == index + 1
        else
          return curr_node.value || nil
        end

      end

    else
      return @root.keys.include?(moves) ? @root[moves].value : nil
    end
  end

  class Node

    attr_accessor :value, :nodes

    def initialize(value)
      @value = value
      @nodes = {}
    end
  end

  def is_leaf?
    return @nodes.empty?
  end

end