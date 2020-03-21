class Knight
	attr_accessor :pos, :color, :sym, :direction, :limit
	def initialize(pos, color)
		@pos = pos
		@color = color
		if color == 'black'
			@sym = "\u{265E}"
		elsif color == 'white'
			@sym = "\u{2658}"
		end

		@direction = nil
		@limit = nil
	end
end