class Rook
	attr_accessor :pos, :color, :sym
	def initialize(pos, color)
		@pos = pos
		@color = color

		if color == 'black'
			@sym = "\u{265C}"
		elsif color == 'white'
			@sym = "\u{2656}"
		end
	end
end