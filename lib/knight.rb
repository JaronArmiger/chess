class Knight
	attr_accessor :pos, :color, :sym
	def initialize(pos, color)
		@pos = pos
		@color = color
		if color == 'white'
			@sym = "\u{265E}"
		elsif color == 'black'
			@sym = "\u{2658}"
		end
	end
end