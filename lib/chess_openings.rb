require 'pgn'
require 'json'

require_relative 'chess_openings/opening.rb'
require_relative 'chess_openings/search_tree.rb'

class ChessOpenings

  attr_accessor :tree, :list

  def initialize
    @tree = SearchTree.new
    @list = []

    file = "lib/chess_openings/json_openings/openings.json"

    openings = JSON.load(File.open(file))["openings"]
    openings.each do |op|
      opening = Opening.new(op["name"], op["eco_code"], op["moves"])
      @list << opening
      @tree.insert opening.moves, opening
    end

  end

  def get_all
    @list.dup
  end

  def get_opening_from_moves(moves)
    @tree.search moves
  end

  def get_opening_from_pgn(file_name)
    raise LoadError, "File does not exist" unless File.exist?(file_name)
    begin
      game = PGN.parse(File.read(file_name)).first
      @tree.search game.moves
    rescue
      raise InvalidPGNError, "Invalid PGN file"
    end
  end

  def search_by_name(name)
    @list.select { |op| op.name.downcase.include?(name.downcase) }
  end

  def get_openings_that_start_with(moves)
    @tree.search_all_with_moves moves
  end

  def get_opening_from_string(string)
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

  def to_s
    @tree.to_s
  end

  private

end

class InvalidPGNError < RuntimeError

end