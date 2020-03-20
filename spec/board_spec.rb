require './lib/board.rb'

describe Board do
	before { @board = Board.new }
	describe "#translate_pos" do
		it "converts traditional chess position notation to array-readable notation" do
			expect(@board.translate_pos("a1")).to eql([0,0])
		end
	end
end