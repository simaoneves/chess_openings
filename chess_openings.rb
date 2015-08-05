require 'pgn'

class ECO

  attr_accessor :moves, :game

  def initialize
    @game = PGN.parse(File.read("./pgn_files/game_1.pgn")).first
    @moves = @game.moves
    @eco_tree = Eco_Tree.new
  end

  def get_move(move_num, player)
    move = move_num - 1
    player == "white" ? @game.moves[move * 2] : @game.moves[(move * 2) + 1]
  end

  def get_eco
    # return @eco_tree.search("b4")
    # return @eco_tree.search(["d4", "d5", "c4", "Bxf5"])
    return @eco_tree.search @moves
    # @moves.each do |move|
    #   @eco_tree.search(move)
    # end
  end

  def to_s
    @eco_tree.to_s
  end

  private

  class SearchTree

    attr_accessor :root

    def initialize
      @root = {}
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
        return @root[moves].value
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

  class Opening

    attr_accessor :name, :eco

    def initialize(name, eco)
      @name = name
      @eco = eco
    end

  end

  class Eco_Tree

    attr_accessor :tree

    def initialize
      @tree = SearchTree.new
      @tree.insert "b4", Opening.new("Polish (Sokolski) opening", "A00")
      @tree.insert ["d4", "d5", "c4"], Opening.new("Queens Gambit", "D06")
      @tree.insert ["d4", "d5", "c4", "Bf5"], Opening.new("Queen's Gambit Declined, Grau (Sahovic) defence", "D06")
      @tree.insert ["d4", "d5", "c4", "Nf6"], Opening.new("Queen's Gambit Declined, Marshall defence", "D06")
      @tree.insert ["d4", "d5", "c4", "c5"], Opening.new("Queen's Gambit Declined, symmetrical (Austrian) defence", "D06")
      @tree.insert ["e4", "e5", "Bc4"], Opening.new("Bishop's Opening", "C23")
      @tree.insert ["e4", "e5", "Bc4", "Nf6"], Opening.new("Bishop's Opening, Berlin defense", "C24")
    end

    def search(moves)
      @tree.get(moves)
    end

    def to_s
      @tree.to_s
    end

    

  end
end

eco_game = ECO.new
# puts eco_game.to_s
puts eco_game.get_eco.name
