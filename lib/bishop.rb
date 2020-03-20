class Bishop
	attr_accessor :pos, :color, :sym
	def initialize(pos, color)
		@pos = pos
		@color = color
		if color == 'white'
			@sym = "\u{265D}"
		elsif color == 'black'
			@sym = "\u{2657}"
		end
	end
end