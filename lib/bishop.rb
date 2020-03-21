class Bishop
	attr_accessor :pos, :color, :sym, :direction, :limit
	def initialize(pos, color)
		@pos = pos
		@color = color
		if color == 'black'
			@sym = "\u{265D}"
		elsif color == 'white'
			@sym = "\u{2657}"
		end

		@direction = ['up-left','up-right','down-left','down-right']
		@limit = 9
	end
end