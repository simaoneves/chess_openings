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

end