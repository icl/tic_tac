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

    def over?
      false
    end

    def winner
      nil
    end

    def tied?
      false
    end

    def random_move
      Random.new.rand(1..dimension_squared)
    end
  end

end
