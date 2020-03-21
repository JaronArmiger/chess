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

describe Board do
	before { 	@board = Board.new 
				}
	describe "#translate_pos" do
		it "converts traditional chess position notation to array-readable notation" do
			expect(@board.translate_pos("a1")).to eql([0,0])
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
		before {@rook = Rook.new('a1','black')
				@board.field[0][0] = @rook
				}
		it "returns array containing all possible moves for rook as only piece on board" do
			
			expect(@board.check_moves(@rook)).to eql([[0, 1], [0, 2], [0, 3], [0, 4], [0, 5], [0, 6], [0, 7], [1, 0], [2, 0], [3, 0], [4, 0], [5, 0], [6, 0], [7, 0]])
		end

		it "returns above shortened array when friendly piece is on its move path" do
		end
	end
end