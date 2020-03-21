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

	describe "#occupied?" do
		it "returns true if there is a piece at given position" do
			@board.field[3][3] = "\u{2655}"
			expect(@board.occupied?([3,3])).to be true
		end
		it "returns false if the given position is vacant" do
			expect(@board.occupied?([3,3])).to be false
		end
	end

	describe "#pawn_moves" do
		it "returns array containing [x,y+1] and [x,y+1] if neither of those squares is occupied" do
			expect(@board.pawn_moves(1,1)).to eql([[1,2],[1,3]])
		end 
	end
end