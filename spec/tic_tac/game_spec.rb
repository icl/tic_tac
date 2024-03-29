require './spec/spec_helper'
require './lib/tic_tac'


module  TicTac 
describe Game do

  before do
    @x_winner = %w[ X X X
                    - - -
                    - - - ]
    @o_winner = %w[ O O O
                    - - -
                    - - - ]

    @new_board = %w[ - - -
                       - - -
                       - - - ]

    @cat_board = %w[ X X O
                     O O X
                     X O O ]

    @vertical_win = %w[- X -
                       - X -
                       - X -]

    @diagonal_win = %w[ X - -
                        - X -
                        - - X ]
  end

  it "should accept an array showing the state of the board" do
    Game.new(state: %w[ - - -
                       - - -
                       - - - ])
  end

  it "should assume a dimension of 3" do
    Game.new.dimension.should == 3
  end

  it "should accept a dimension parameter" do
    Game.new(dimension:4).dimension.should == 4
  end

  describe "Determining whether the game is over" do

    it "should not think a new game is over" do
      Game.new.should_not be_over
    end

    it "should recognize if a player has a already won" do
      game = Game.new(state: @x_winner , dimension: 3)
      game.should be_over
    end

  end

  describe "recognizing a tie" do
    it "should recognize a tie" do
      game = Game.new(state: @tie_game).should be_tied
    end

    it "should not think a new game is a tie" do
      Game.new.should_not be_tied
    end
  end

  describe "Finding a winner" do
    it "should not think a new game has a winner" do
      Game.new.winner.should be_nil
    end

    it "should recognize if play X has won" do
      Game.new( state: @x_winner).winner.should == 'X'   
    end

    it "should recognize if player O has won" do
      Game.new( state: @o_winner).winner.should == 'O'
    end

    it "should recognize a horizontal win" do
      Game.new(state: @x_winner).winner.should == 'X'
    end

    it "should recognize a vertical win" do

      Game.new(state: @vertical_win).winner.should == 'X'
    end

    it "should recognize a diagonal win" do
      Game.new(state: @diagonal_win).winner.should == 'X'
    end
  end

  describe "Making good moves" do
    describe "next move" do
      it "should respond with index of the next the next move" do
        Game.new().next_move
      end

      it "should not move if the game is over" do
        Game.new(state:@x_winner).next_move.should be_nil
      end

      it "should update its state if make_move! is called" do
        game = Game.new()
        game.make_move!
      end

      it "should persist in making moves even if a tie is a forgon conclusion" do
        game = Game.new(state: ["X", "X", "O", "X",
                               "-", "X", "O", "-", 
                               "O", "X", "X", "-", 
                               "X", "O", "O", "O"] , dimension: 4)

        game.next_move.should_not be_nil
      end
    end
  end

  describe "Making random moves" do

    it "should attempt to make a random move" do
      Game.new(state: @new_board).random_move.should_not be_nil
    end

    it "should move within the bounds of the game" do
      100.times do 
      (1..25).should include Game.new(dimension:5).random_move
      end
    end

    it "should not move a space that has already been used" do

      game = Game.new(dimension:5)
      
      100.times do
        game.mark_at_position( game.random_move).should == '-'
      end
    end

    it "should not move on a full board" do
     game = Game.new(state: @cat_board)
     game.random_move.should be_nil
    end

  end

  describe "utility methods" do
    it "should square its dimension" do
      Game.new(dimension: 4).dimension_squared.should == 16
    end
  end
end

end
