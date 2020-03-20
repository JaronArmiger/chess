class Pawn
	attr_accessor :pos, :color, :sym, :owner
	def initialize(pos, color, owner)
		@pos = pos
		@color = color
		@owner = owner
		if color == 'white'
			@sym = "\u{2659}"
		elsif color == 'black'
			@sym = "\u{265F}"
		end
	end

	def valid_moves(curr_pos)
	end
end