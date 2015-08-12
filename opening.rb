class Opening

  attr_accessor :name, :eco, :moves

  def initialize(name, eco, moves)
    @name = name
    @eco = eco
    @moves = moves
  end

  def to_s
    "#{@eco}: #{@name}\n#{@moves}"
  end

  def to_h
    { "name" => @name, "eco" => @eco, "moves" => @moves }
  end

end