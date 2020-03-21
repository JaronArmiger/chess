class Board
	attr_accessor :field
	def initialize
		@field = make_field
	end

	def make_field
		field_arr = []
		8.times do 
			column = []
			8.times do
				column << nil
			end
			field_arr << column
		end
		field_arr
	end


	def show
		puts "    a   b   c   d   e   f   g   h "
		
		top_line = "   "
		8.times do
			top_line << "____"
		end

		line = "  |"
		8.times do
			line << "___|"
		end
		puts top_line

		col_arr = [7,6,5,4,3,2,1,0]
		col_arr.each do |col|
			print "#{col + 1} "
			8.times do |row|
				if field[row][col].nil?
					print "|   "
				else
					print "| #{field[row][col]} "
				end
			end
			print "|"
			puts ""
			puts line
		end
		puts ""
	end

	def translate_pos(board_pos)
		letter = board_pos[0]
		num = board_pos[1].to_i
		arr_pos = [letter.ord - 97, num - 1]
	end

	def populate(pieces_hash)
		pieces_hash.each do |name, piece|
			arr_pos = translate_pos(piece.pos)
			field[arr_pos[0]][arr_pos[1]] = piece.sym
		end
	end

	def color(square)
		case square
		when "\u{265F}" || "\u{265C}" || "\u{265E}" || "\u{265D}" || "\u{265B}" || "\u{265A}"
			return "black"
		when "\u{2659}" || "\u{2656}" || "\u{2658}" || "\u{2657}" || "\u{2655}" || "\u{2654}"
			return "white"
		end
	end

	def occupied(arr_pos)
		square = field[arr_pos[0]][arr_pos[1]]
		if square.nil?
			return false 
		else
			return color(square)
		end
	end

	def valid_moves(piece,board_pos)
		arr_pos = translate_pos(board_pos)
		x = arr_pos[0]
		y = arr_pos[1]
		if piece.is_a? Pawn
			moves = pawn_moves(x,y)
		elsif piece.is_a? Rook
			moves = rook_moves(x,y)
		elsif piece.is_a? Knight
			moves = knight_moves(x,y)
		elsif piece.is_a? Bishop
			moves = bishop_moves(x,y)
		elsif piece.is_a? Queen
			moves = queen_moves(x,y)
		elsif piece.is_a? King
			moves = king_moves(x,y)
		end
		moves
	end

	def pawn_moves(x,y)
		moves = []
		moves << [x,y+1] unless occupied?([x,y+1])
		moves << [x,y+2] unless occupied?([x,y+2])
		moves
	end

	def rook_moves(x,y)
	end

	def knight_moves(x,y)
	end

	def bishop_moves(x,y)
	end

	def queen_moves(x,y)
	end

	def king_moves(x,y)
	end


end