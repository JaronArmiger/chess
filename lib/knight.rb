class Knight
	attr_accessor :pos, :color, :sym, :direction, :limit, :moved_yet
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
		@moved_yet = false
	end
	
	def to_json(*a)
		{
			:pos => @pos, 
			:color => @color, 
			:sym => @sym, 
			:direction => @direction, 
			:limit => @limit, 
			:moved_yet => @moved_yet
		}.to_json(*a)
	end

	def self.from_json(data)
		pos = data['pos']
		color = data['color']
		piece = self.new(pos,color)
		piece.moved_yet = data['moved_yet']
		piece
	end
end