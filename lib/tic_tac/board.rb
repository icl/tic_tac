module TicTac
  class Board < Array
    attr_accessor :dimension

    
    def less_dimension
      dimension - 1
    end

    def more_dimension
      dimension + 1
    end

    def rows
      row_offsets.collect do | offset|
        slice(offset..( offset + less_dimension) )
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
          at index
        end.flatten
      end 
    end

    def diagonals
      right = (0..less_dimension).collect do | multiplier|
        index = multiplier * more_dimension
        at index
      end.flatten

      left = (1..dimension).collect do | multiplier |
        index = multiplier * less_dimension
        at index
      end.flatten

      [right,left]
      
    end


  end
end
