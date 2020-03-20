class King
	attr_accessor :pos, :color, :sym, :owner
	def initialize(pos, color, owner)
		@pos = pos
		@color = color
		@owner = owner
		if color == 'white'
			@sym = "\u{265A}"
		elsif color == 'black'
			@sym = "\u{2654}"
		end
	end
end