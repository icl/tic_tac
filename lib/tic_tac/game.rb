module TicTac
  class Game

    attr_accessor :dimension
    def initialize options = {}
      @dimension = options[:dimension] || 3
      @state = options[:state] || Array.new.fill('-', 0, dimension_squared)
      @conversions = {0 => 'O', 1 => 'X', 2 => nil}
    end


    def over?
      winner || tied?
    end

    def winner
      horizontal_winner || vertical_winner || diagonal_winner
    end

    def horizontal_winner
      rows.collect do | row |
        winner_in row
      end.flatten.compact.first
    end

    def winner_in pattern
      case
        when pattern.count('X') == dimension
          'X'
        when pattern.count('O') == dimension
          'O'
        else
          nil
        end

    end

    def vertical_winner
      columns.collect do | column |
        winner_in column
      end.flatten.compact.first
    end

    def diagonal_winner
      diagonals.collect do | diagonal |
        winner_in diagonal
      end.flatten.compact.first

    end

    def tied?
      false
    end

    def random_move
      available_positions.shuffle.first + 1 if !available_positions.empty?
    end

    def mark_at_position position
      @conversions[@state[position -1]]
    end
    def available_positions
      @state.each_with_index.collect { | v, i |  i if v.match('-') }.compact
    end

    def dimension_squared
      @dimension * @dimension
    end

    def rows
      row_offsets.collect do | offset|
        @state.slice(offset..( offset + less_dimension) )
      end
    end

    def row_offsets
      (0..less_dimension).collect do | number| 
        number * dimension
      end
    end

    def columns
      (0..less_dimension).collect do |offset|
        (0..less_dimension).collect do |multiplier|
          index = offset + dimension * multiplier
          @state[index]
        end.flatten
      end 
    end

    def diagonals
      right = (0..less_dimension).collect do | multiplier|
        index = multiplier * more_dimension
        @state[index]
      end.flatten

      left = (1..dimension).collect do | multiplier |
        index = multiplier * less_dimension
        @state[index]
      end.flatten

      [right,left]
      
    end

    def less_dimension
      dimension - 1
    end

    def more_dimension
      dimension + 1
    end

  end

end
