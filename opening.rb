class Opening

  attr_accessor :name, :eco_code, :moves

  def initialize(name, eco_code, moves)
    @name = name
    @eco_code = eco_code
    @moves = moves
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
        result += "#{(index / 2.0).ceil}. #{move}"
      elsif index.even? && @moves.size != index
        result += " #{move} "
      else
        result += " #{move}"        
      end

      index += 1
    end
    return result
  end
end