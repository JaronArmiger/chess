class Pawn
	attr_accessor :pos, :color, :sym
	def initialize(pos, color)
		@pos = pos
		@color = color

		if color == 'white'
			@sym = "\u{2659}"
		elsif color == 'black'
			@sym = "\u{265F}"
		end
	end

	def valid_moves(curr_pos)
	end
end