class Player
	attr_accessor :name, :color, :pieces, :check
	def initialize(name,color)
		@name = name
		@color = color
		@pieces = make_pieces
		@check = false
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

	def self.from_json(data)
		p_name = data['name']
		color = data['color']
		player = self.new(p_name,color)
		obj_pieces_hash = {}
		json_pieces_hash = data['pieces']
		json_pieces_hash.each do |piece_name, piece_info|
			if piece_name =~ /pawn/
				piece = Pawn.from_json(piece_info)
			elsif piece_name =~ /rook/
				piece = Rook.from_json(piece_info)
			elsif piece_name =~ /knight/
				piece = Knight.from_json(piece_info)
			elsif piece_name =~ /bishop/
				piece = Bishop.from_json(piece_info)
			elsif piece_name =~ /queen/
				piece = Queen.from_json(piece_info)
			elsif piece_name =~ /king/
				piece = King.from_json(piece_info)
			end
			obj_pieces_hash[piece_name] = piece
		end
		player.pieces = obj_pieces_hash
		player.check = data['check']
		player
		#pieces_data = data['pieces']
	end

	def to_json(*a)
		{
			:name => @name,
			:color => @color,
			:pieces => @pieces,
			:check => @check
		}.to_json(*a)
	end

end