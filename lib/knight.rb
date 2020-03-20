class Knight
	attr_accessor :pos, :color, :sym, :owner
	def initialize(pos, color, owner)
		@pos = pos
		@color = color
		@owner = owner
		if color == 'white'
			@sym = "\u{265E}"
		elsif color == 'black'
			@sym = "\u{2658}"
		end
	end
end