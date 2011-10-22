module TicTac
  class Game

    attr_accessor :dimension
    def initialize options = {}
      @dimension = options[:dimension] || 3
      @state = Board.new(options[:state] || Array.new.fill('-', 0, dimension_squared))
      @state.dimension = @dimension
    end


    def over?
      winner || tied?
    end

    def winner
      horizontal_winner || vertical_winner || diagonal_winner
    end

    def horizontal_winner
      @state.rows.collect do | row |
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
      @state.columns.collect do | column |
        winner_in column
      end.flatten.compact.first
    end

    def diagonal_winner
      @state.diagonals.collect do | diagonal |
        winner_in diagonal
      end.flatten.compact.first

    end

    def tied?
      false
    end

    def random_move
      available_positions.shuffle.first if !available_positions.empty?
    end

    def mark_at_position position
      @state[position - 1 ]
    end

    def available_positions
      @state.each_with_index.collect { | v, i |  i + 1 if v.match('-') }.compact
    end

    def dimension_squared
      @dimension * @dimension
    end

  end

end
