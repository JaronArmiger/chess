require './lib/board.rb'
require './lib/game.rb'
require './lib/player.rb'
require './lib/piece.rb'
require './lib/pawn.rb'
require './lib/rook.rb'
require './lib/knight.rb'
require './lib/bishop.rb'
require './lib/king.rb'
require './lib/queen.rb'

describe Game do
	before { @game = Game.new }
	describe "#valid_pos_name?" do
		it "returns true if pos is on board" do
			expect(@game.valid_pos_name?("a1")).to be true
		end

		it "returns false if pos is not on board" do
			expect(@game.valid_pos_name?("u1")).to be false
		end
	end

	
end


describe Board do
	before { 	@board = Board.new 
				}

	describe "#board_to_arr" do
		it "converts traditional chess position notation to array-readable notation" do
			expect(@board.board_to_arr("d5")).to eql([3,4])
		end
	end

	describe "#arr_to_board" do
		it "converts array notation to traditional chess notation" do
			expect(@board.arr_to_board([1,2])).to eql("b3")
		end
	end

	describe "#occupied" do
		it "returns 'black' if there is a black piece at given position" do
			@board.field[3][3] = Pawn.new('d4','black')
			expect(@board.occupied([3,3])).to eql('black')
		end
		it "returns 'black' if there is a black piece at given position" do
			@board.field[3][3] = Pawn.new('d4','white')
			expect(@board.occupied([3,3])).to eql('white')
		end
		it "returns false if the given position is vacant" do
			expect(@board.occupied([3,3])).to be false
		end
	end

	describe "#check_moves" do
		before { @rook = Rook.new('a1','black')
				@board.field[0][0] = @rook
				}
		it "returns array containing all possible moves for rook as only piece on board" do
			expect(@board.check_moves(@rook)).to eql(["a2", "a3", "a4", "a5", "a6", "a7", "a8", "b1", "c1", "d1", "e1", "f1", "g1", "h1"])
		end

		it "returns  shortened array when friendly piece is on rook's move path" do
			new_rook = Rook.new('d1', 'black')
			@board.field[4][0] = new_rook
			expect(@board.check_moves(@rook)).to eql(["a2", "a3", "a4", "a5", "a6", "a7", "a8", "b1", "c1", "d1"])
		end

		it "returns same array as above, with the addition of square containing opposing piece when opposing piece lies on rook's move path" do
			new_rook = Rook.new('d1', 'white')
			@board.field[4][0] = new_rook
			expect(@board.check_moves(@rook)).to eql(["a2", "a3", "a4", "a5", "a6", "a7", "a8", "b1", "c1", "d1", "e1"])
		end
	end

	describe "#pawn_moves" do
		before { @pawn = Pawn.new('b2', 'black')
				 @board.field[1][1] = @pawn }
		it "returns array containing the two squares above it when its path is clear and no pieces lie on its diagonals" do
			expect(@board.pawn_moves(@pawn)).to eql(["b3", "b4"])
		end

		it "returns same array, with addition of up-left adjacent diagonal, when that square is occupied by opposing piece" do
			queen = Queen.new('c1','white')
			@board.field[0][2] = queen
			expect(@board.pawn_moves(@pawn)).to eql(["b3", "b4", "a3"])
		end
	end

	describe "#knight_moves" do
		before { @knight = Knight.new('c4','black')
				 @board.field[2][3] = @knight }
		it "returns array of 8 possible moves for knight in middle of board" do
			expect(@board.knight_moves(@knight)).to eql(["d6", "e5", "e3", "d2", "b2", "a3", "a5", "b6"])
		end
	end

	describe "#valid_moves" do
		before { @rook = Rook.new('a1','black')
				 @board.field[0][0] = @rook

				 @pawn = Pawn.new('b2', 'black')
				 @board.field[1][1] = @pawn

				 @knight = Knight.new('c4','black')
				 @board.field[2][3] = @knight 

				  }
		it "returns same output as #check_moves for rook" do
			moves = @board.check_moves(@rook)
			expect(@board.valid_moves(@rook)).to eql(moves)
		end

		it "returns the same output as #pawn_moves for pawn" do
			moves = @board.pawn_moves(@pawn)
			expect(@board.valid_moves(@pawn)).to eql(moves)
		end

		it "returns the same output as #knight_moves for knight" do
			moves = @board.knight_moves(@knight)
			expect(@board.valid_moves(@knight)).to eql(moves)
		end
	end
end