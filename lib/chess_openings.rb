require 'pgn'
require 'json'

require 'chess_openings/opening.rb'
require 'chess_openings/search_tree.rb'

# Class responsible for searching for chess Openings
class ChessOpenings
  attr_accessor :tree, :list

  def initialize
    @tree = SearchTree.new
    @list = []
    file = '/chess_openings/json_openings/openings.json'
    openings_file = File.join(File.dirname(__FILE__), file)
    openings = JSON.load(File.open(openings_file))['openings']
    openings.each do |op|
      opening = Opening.new(op['name'], op['eco_code'], op['moves'])
      @list << opening
      @tree.insert opening.moves, opening
    end
  end

  # Get all openings available
  #
  # @return [Array] Array with all the Openings possible
  def all
    @list.dup
  end

  # Get Opening from moves (as symbols or strings)
  #
  # @param [Array] moves Array with strings or symbols
  # @return [Opening] Opening that has exactly the moves in the argument
  def from_moves(moves)
    @tree.search moves
  end

  # Get Opening from a PGN file
  #
  # @param [String] file_name String with the path to the PGN file
  # @return [Opening] Opening that was used in the PGN game
  # @raise [InvalidPGNError] Path points to invalid PGN file
  # @raise [LoadError] Path points to non existent file
  def from_pgn(file_name)
    raise LoadError, 'File does not exist' unless File.exist?(file_name)
    begin
      game = PGN.parse(File.read(file_name)).first
      @tree.search game.moves.map(&:notation)
    rescue
      raise InvalidPGNError, 'Invalid PGN file'
    end
  end

  # Search Openings by name
  #
  # @param [String] name String with the name to search for
  # @return [Array] Array with all the Openings found
  def with_name(name)
    @list.select { |op| op.name.downcase.include?(name.downcase) }
  end

  # Search all Openings that start with the moves in the argument
  #
  # @param [Array] moves Moves to be searched for
  # @return [Array] Array with all Openings that start with the moves provided
  def that_start_with(moves)
    @tree.search_all_with_moves moves
  end

  # Get Opening from a PGN formatted String
  #
  # @param [String] string String in PGN format
  # @return [Opening] Opening that was used in PGN formatted String
  def from_string(string)
    array = string.split
    moves = []
    array.each do |move|
      if move.include?('.')
        next if move.end_with?('.')
        move = move.split('.').last
      end
      moves << move
    end
    @tree.search moves
  end

  # Get Opening from FEN string
  #
  # @param [String] fen_string FEN formatted String
  # @return [Opening] Opening that was used in the game of the FEN String
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

# Exception raised when there is a error reading a PGN file
class InvalidPGNError < RuntimeError
end
