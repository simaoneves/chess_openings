require 'pgn'
require_relative 'chess_openings_helper.rb'

# Class that represents a chess Opening
class Opening
  attr_accessor :name, :eco_code, :moves

  def initialize(name, eco_code, moves)
    @name = name
    @eco_code = eco_code
    @moves = moves.map! { |move| move.is_a?(String) ? move.to_sym : move }
  end

  # String representation of Opening
  #
  # @return [String] String that represents an Opening
  def to_s
    "#{@eco_code}: #{@name}\n#{@moves}"
  end

  # Hash representation of Opening
  #
  # @return [Hash] Hash that represents an Opening
  def to_h
    { 'name' => @name, 'eco_code' => @eco_code, 'moves' => @moves }
  end

  # Compares two Openings
  #
  # @param [Opening] other Opening to be compared
  # @return [Boolean] True if both Openings have same values, false otherwise
  def ==(other)
    @name == other.name && @eco_code == other.eco_code && @moves == other.moves
  end

  # Returns PGN formatted String of the Opening
  #
  # @return [String] String that represents a game where Opening was used
  def to_pgn
    result = ''
    index = 1
    @moves.each do |move|
      result += index.odd? ? "#{(index / 2.0).ceil}.#{move}" : " #{move} "
      index += 1
    end
    result.chop!
  end

  # Returns FEN formatted String representation of the Opening
  #
  # @return [String] String that represents a game where Opening was used
  def to_fen
    moves = ChessOpeningsHelper.moves_as_strings(@moves)
    PGN::Game.new(moves).fen_list.last
  end
end
