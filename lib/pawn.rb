class Pawn
	attr_accessor :pos, :color, :sym, :direction, :limit, :moved_yet
	def initialize(pos, color)
		@pos = pos
		@color = color
		if color == 'white'
			@sym = "\u{2659}"
		elsif color == 'black'
			@sym = "\u{265F}"
		end

		@direction = ['up']
		@limit = 2
		@moved_yet = false
	end
end