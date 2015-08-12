class SearchTree

  attr_accessor :root

  def initialize
    @root = {}
    load_openings
  end

  def load_openings
    openings = File.readlines("openings_array.rb")
    num_of_openings = openings[0]
    index = 1
    counter = 0

    result = []

    while counter < num_of_openings.to_i
      counter += 1

      name = openings[index].chomp
      eco = openings[index + 1].chomp
      moves_array = openings[index + 2].split(', ')

      moves_array.last.chomp!
      # puts "==========="
      # puts "Treating opening number #{counter}"
      # puts "==========="

      
      result << Opening.new(name, eco, moves_array)

      
      index += 4
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

        if curr_hash[move].nil?
          return curr_node.value || nil
        else
          curr_node = curr_hash[move]
          curr_hash = curr_hash[move].nodes
          return curr_node.value if curr_hash.empty? || moves.size == index + 1
        end

      end

    else
      return @root[moves].nil? ? nil : @root[moves].value
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