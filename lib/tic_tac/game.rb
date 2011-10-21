module TicTac
  class Game

    attr_accessor :dimension
    def initialize options = {}
      @dimension = options[:dimension] || 3
      @state = options[:state] || Array.new.fill('-', 0, dimension_squared)
      @conversions = {0 => 'O', 1 => 'X', 2 => false}
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
      available_positions.shuffle.first + 1 if !available_positions.empty?
    end

    def available_positions
      @state.each_with_index.collect { | v, i |  i if v.match /-/ }.compact
    end

    def dimension_squared
      @dimension * @dimension
    end

  end

end
