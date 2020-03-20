class Rook
	attr_accessor :pos, :color, :sym, :owner
	def initialize(pos, color, owner)
		@pos = pos
		@color = color
		@owner = owner
		if color == 'white'
			@sym = "\u{265C}"
		elsif color == 'black'
			@sym = "\u{2656}"
		end
	end
end