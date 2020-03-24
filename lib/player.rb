class Player
	attr_accessor :name, :color, :pieces
	def initialize(name,color)
		@name = name
		@color = color
		@pieces = make_pieces
	end

	def make_pieces
		if color == 'black'
			pawn_row = 2
			army_row = 1
		elsif color == 'white'
			pawn_row = 7
			army_row = 8
		end

		pieces = {}

		alpha = ["a","b","c","d","e","f","g","h"]
		pre = color[0]
		alpha.each_with_index do |letter, idx|
			pieces["pawn_#{idx+1}"] = Pawn.new("#{letter}#{pawn_row}",color)
		end


		pieces["rook_1"] = Rook.new("a#{army_row}",color)
		pieces["rook_2"] = Rook.new("h#{army_row}",color)

		pieces["knight_1"] = Knight.new("b#{army_row}",color)
		pieces["knight_2"] = Knight.new("g#{army_row}",color)

		pieces["bishop_1"] = Bishop.new("c#{army_row}",color)
		pieces["bishop_2"] = Bishop.new("f#{army_row}",color)

		pieces["queen"] = Queen.new("e#{army_row}",color)

		pieces["king"] = King.new("d#{army_row}",color)
		pieces
	end

	def list_pieces
		@pieces.each do |name, piece|
			print "#{name} => pos: #{piece.pos}\n"
		end
	end
end