require 'pgn'
require 'json'

require 'chess_openings/opening.rb'
require 'chess_openings/search_tree.rb'

class ChessOpenings

  attr_accessor :tree, :list

  def initialize
    @tree = SearchTree.new
    @list = []

    file = "/chess_openings/json_openings/openings.json"
    openings_file = File.join(File.dirname(__FILE__), file)

    openings = JSON.load(File.open(openings_file))["openings"]
    openings.each do |op|
      opening = Opening.new(op["name"], op["eco_code"], op["moves"])
      @list << opening
      @tree.insert opening.moves, opening
    end

  end

  def get_all
    @list.dup
  end

  def from_moves(moves)
    @tree.search moves
  end

  def from_pgn(file_name)
    raise LoadError, "File does not exist" unless File.exist?(file_name)
    begin
      game = PGN.parse(File.read(file_name)).first
      @tree.search game.moves.map(&:notation)
    rescue
      raise InvalidPGNError, "Invalid PGN file"
    end
  end

  def with_name(name)
    @list.select { |op| op.name.downcase.include?(name.downcase) }
  end

  def that_start_with(moves)
    @tree.search_all_with_moves moves
  end

  def from_string(string)
    array = string.split
    moves = []
    array.each do |move|
      if move.include?(".")
        next if move.end_with?(".")
        move = move.split(".").last
      end
      moves << move
    end
    @tree.search moves
  end

  def from_fen(fen_string)
    fen = PGN::FEN.new(fen_string)
    move_number = (fen.fullmove.to_i - 1) * 2
    final_list = @tree.get_moves_in_depth(move_number)
    final_list.select { |op| op.to_fen == fen_string }.first
  end

  private

    def to_s
      @tree.to_s
    end

end

class InvalidPGNError < RuntimeError

end
