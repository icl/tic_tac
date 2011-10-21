module TicTac
  class Game

  attr_accessor :dimension
  def initialize options = {}
    @dimension = options[:dimension] || 3
    @state = options[:state] || Array.new.fill('-', 0, dimension_squared)
    @conversions = {0 => 'O', 1 => 'X', 2 => false}
  end
  def dimension_squared
    @dimension * @dimension
  end

  end
end
