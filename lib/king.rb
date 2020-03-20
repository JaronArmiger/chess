class King
	attr_accessor :pos, :color, :sym
	def initialize(pos, color)
		@pos = pos
		@color = color

		if color == 'white'
			@sym = "\u{265A}"
		elsif color == 'black'
			@sym = "\u{2654}"
		end
	end
end