class ChessOpeningsHelper

  def self.moves_as_symbols(moves)
    moves.map { |move| move.is_a?(String)? move.to_sym : move }
  end

  def self.moves_as_strings(moves)
    moves.map { |move| move.is_a?(Symbol)? move.to_s : move }
  end

end