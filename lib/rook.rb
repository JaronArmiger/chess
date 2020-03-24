class Rook
	attr_accessor :pos, :color, :sym, :direction, :limit, :moved_yet
	def initialize(pos, color)
		@pos = pos
		@color = color
		if color == 'black'
			@sym = "\u{265C}"
		elsif color == 'white'
			@sym = "\u{2656}"
		end

		@direction = ['up','down','left','right']
		@limit = 9
		@moved_yet = false
	end
end