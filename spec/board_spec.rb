require './lib/board.rb'

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
end