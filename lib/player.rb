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
		elsif color = 'white'
			pawn_row = 7
			army_row = 8
		end

		pieces = {}

		alpha = ["a","b","c","d","e","f","g","h"]
		pre = color[0]
		alpha.each_with_index do |letter, idx|
			pieces["@#{pre}_pawn_#{idx+1}"] = Pawn.new("#{letter}#{pawn_row}",color)
		end


		pieces["@#{pre}_rook_1"] = Rook.new("a#{army_row}",color)
		pieces[("@#{pre}_rook_2"] = Rook.new("h#{army_row}",color,player)

		pieces["@#{pre}_knight_1"] = Knight.new("b#{army_row}",color)
		pieces["@#{pre}_knight_2"] = Knight.new("g#{army_row}",color)

		pieces["@#{pre}_bishop_1"] = Bishop.new("c#{army_row}",color)
		pieces["@#{pre}_bishop_2"] = Bishop.new("f#{army_row}",color

		pieces["@#{pre}_queen"] = Queen.new("d#{army_row}",color)

		pieces["@#{pre}_king"] = King.new("h#{army_row}",color)
		pieces
	end
end