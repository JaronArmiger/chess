class Queen
	attr_accessor :pos, :color, :sym
	def initialize(pos, color)
		@pos = pos
		@color = color
		if color == 'white'
			@sym = "\u{265B}"
		elsif color == 'black'
			@sym = "\u{2655}"
		end
	end
end