class Bishop
	attr_accessor :pos, :color, :sym, :owner
	def initialize(pos, color, owner)
		@pos = pos
		@color = color
		@owner = owner
		if color == 'white'
			@sym = "\u{265D}"
		elsif color == 'black'
			@sym = "\u{2657}"
		end
	end
end