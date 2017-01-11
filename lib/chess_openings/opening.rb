require 'pgn'
require_relative 'chess_openings_helper.rb'

class Opening

  attr_accessor :name, :eco_code, :moves

  def initialize(name, eco_code, moves)
    @name = name
    @eco_code = eco_code
    @moves = moves.map! { |move| move.is_a?(String)? move.to_sym : move }
  end

  def to_s
    "#{@eco_code}: #{@name}\n#{@moves}"
  end

  def to_h
    { "name" => @name, "eco_code" => @eco_code, "moves" => @moves }
  end

  def ==(other)
    @name == other.name && @eco_code == other.eco_code && @moves == other.moves
  end

  def to_pgn
    result = ""
    index = 1
    @moves.each do |move|

      if index.odd?
        result += "#{(index / 2.0).ceil}.#{move}"
      elsif index.even? && @moves.size != index
        result += " #{move} "
      else
        result += " #{move}"
      end

      index += 1
    end
    return result
  end

  def to_fen
    moves = ChessOpeningsHelper.moves_as_strings(@moves)
    PGN::Game.new(moves).fen_list.last
  end

end
