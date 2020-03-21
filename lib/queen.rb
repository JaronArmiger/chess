class Queen
	attr_accessor :pos, :color, :sym. :direction, :limit
	def initialize(pos, color)
		@pos = pos
		@color = color
		if color == 'black'
			@sym = "\u{265B}"
		elsif color == 'white'
			@sym = "\u{2655}"
		end

		@direction = ['up','down','left','right','up-left','up-right','down-left','down-right']
		@limit = nil
	end
end