# Helper class with utility functions
class ChessOpeningsHelper

  # Transform contents of array to symbols
  #
  # @param [Array] moves Moves as strings or symbols
  # @return [Array] Array with all moves as symbols
  def self.moves_as_symbols(moves)
    moves.map { |move| move.is_a?(String) ? move.to_sym : move }
  end

  # Transform contents of array to strings
  #
  # @param [Array] moves Moves as strings or symbols
  # @return [Array] Array with all moves as strings
  def self.moves_as_strings(moves)
    moves.map { |move| move.is_a?(Symbol) ? move.to_s : move }
  end

end
