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
					print "| #{field[row][col].sym} "
				end
			end
			print "|"
			puts ""
			puts line
		end
		puts ""
	end

	def board_to_arr(board_pos)
		letter = board_pos[0]
		num = board_pos[1].to_i
		arr_pos = [letter.ord - 97, num - 1]
	end

	def arr_to_board(arr_pos)
		x = arr_pos[0]
		y = arr_pos[1]
		letter = (x + 97).chr
		num = y + 1
		board_pos = "#{letter}#{num}"
	end

	def populate(pieces_hash)
		pieces_hash.each do |name, piece|
			arr_pos = board_to_arr(piece.pos)
			field[arr_pos[0]][arr_pos[1]] = piece
		end
	end

	def occupied(arr_pos)
		square = field[arr_pos[0]][arr_pos[1]]
		if square.nil?
			return false 
		else
			square.color
		end
	end

	def valid_moves(piece)
		if piece.is_a? Pawn
			moves = pawn_moves(piece)
		elsif piece.is_a? Knight
			moves = knight_moves(piece)
		else
			moves = check_moves(piece)
		end
		moves
	end

	def pawn_moves(piece)
		moves = check_moves(piece)
		arr_pos = board_to_arr(piece.pos)
		x = arr_pos[0]
		y = arr_pos[1]
		up_left = field[x-1][y+1]
		up_right = field[x+1][y+1]
		if !up_left.nil?
			if !(up_left.color == piece.color)
				moves << [x-1,y+1]
			end
		end
		if !up_right.nil?
			if !(up_right.color == piece.color)
				moves << [x+1,y+1]
			end
		end
		moves
	end

	def knight_moves(x,y)
	end

	def check_moves(piece)
		arr_pos = board_to_arr(piece.pos)
		moves = []
		#p piece
		until piece.direction.empty?
			#print "direction:"; p piece.direction
			x = arr_pos[0]
			y = arr_pos[1]
			curr_dir = piece.direction.shift
			n = 1
			until n == piece.limit + 1
				case curr_dir
				when 'up'
					y += 1
				when 'down'
					y -= 1
				when 'left'
					x -= 1
				when 'right'
					x += 1
				when 'up-left'
					x -= 1
					y += 1
				when 'up-right'
					x += 1
					y += 1
				when 'down-left'
					x -= 1
					y -= 1
				when 'down-right'
					x += 1
					y -= 1
				end
				if (x >= 0 && x < 8) && (y >= 0 && y < 8)   # next square on board?
					next_square = field[x][y]
				else
					break
				end

				if next_square.nil?
					moves << [x,y]
				elsif next_square.color == piece.color   # same team
					break
				else		# other team
					moves << [x,y]
					break
				end
				n += 1
			end
		end
		moves
	end

	def pretty_moves(moves_arr)
		pretty_arr = []
		moves_arr.each do |pair|
			pretty_arr << arr_to_board(pair)
		end
		pretty_arr
	end
















end