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

	def update(pieces_hash)
		pieces_hash.each do |name, piece|
			arr_pos = board_to_arr(piece.pos)
			field[arr_pos[0]][arr_pos[1]] = piece
		end
		
	end

	def move_piece(piece,destination)
		piece.moved_yet = true
		curr_pos = board_to_arr(piece.pos)
		c_x = curr_pos[0]
		c_y = curr_pos[1]

		destination = board_to_arr(destination)
		d_x = destination[0]
		d_y = destination[1]
		#print "piece: "; p piece
		#print "curr_pos: "; p curr_pos
		#print "destination: "; p destination
		if !occupied(destination) # if destination square is unoccopied
			@field[d_x][d_y] = piece # move piece to destination
			@field[c_x][c_y] = nil # erase it at old location
			piece.pos = arr_to_board(destination) # update piece's position attribute
			return nil
		else # taking opponent's piece at destination square
			taken_piece = @field[d_x][d_y] # save reference to opponent's piece at that square
			@field[c_x][c_y] = nil # erase my piece at old location
			@field[d_x][d_y] = piece # move piece to destination, erasing board's reference to opponent's piece
			piece.pos = arr_to_board(destination)
			return taken_piece # send reference to opponent's piece to Game, to be removed from player's pieces array
		end
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
		if piece.color == 'black'
			if (x-1 >= 0 && x-1 < 8) && (y+1 >= 0 && y+1 < 8)
				up_left = field[x-1][y+1]
			end

			if (x+1 >= 0 && x+1 < 8) && (y+1 >= 0 && y+1 < 8)
				up_right = field[x+1][y+1]
			end

			if !up_left.nil?
				if !(up_left.color == piece.color)
					moves << arr_to_board([x-1,y+1])
				end
			end

			if !up_right.nil?
				if !(up_right.color == piece.color)
					moves << arr_to_board([x+1,y+1])
				end
			end

		elsif piece.color = 'white'
			if (x-1 >= 0 && x-1 < 8) && (y-1 >= 0 && y-1 < 8)
				up_left = field[x-1][y-1]
			end

			if (x+1 >= 0 && x+1 < 8) && (y-1 >= 0 && y-1 < 8)
				up_right = field[x+1][y-1]
			end

			if !up_left.nil?
				if !(up_left.color == piece.color)
					moves << arr_to_board([x-1,y-1])
				end
			end

			if !up_right.nil?
				if !(up_right.color == piece.color)
					moves << arr_to_board([x+1,y-1])
				end
			end
		end
		
		moves
	end

	def knight_moves(piece)
		moves = []
		arr_pos = board_to_arr(piece.pos)
		x = arr_pos[0]
		y = arr_pos[1]
		if piece.color == 'black'
			possible = [[x+1,y+2],[x+2,y+1],[x+2,y-1],[x+1,y-2],[x-1,y-2],[x-2,y-1],[x-2,y+1],[x-1,y+2]]
		elsif piece.color == 'white'
			possible = [[x+1,y-2],[x+2,y-1],[x+2,y+1],[x+1,y+2],[x-1,y+2],[x-2,y+1],[x-2,y-1],[x-1,y-2]]
		end
			
		possible.each do |pair|
			x = pair[0]
			y = pair[1]
			if (x >= 0 && x < 8) && (y >= 0 && y < 8)
				square = field[x][y]
				if square.nil?  # if vacant
					moves << pair
				elsif square.color != piece.color #if enemy
					moves << pair
				end
			end
		end
		moves  = pretty_moves(moves)
	end


	def check_moves(piece)
		#puts "piece.pos #{piece.pos}"
		arr_pos = board_to_arr(piece.pos)
		direction_arr = piece.direction.clone
		moves = []
		if piece.color == 'black'
			until direction_arr.empty?
				x = arr_pos[0]
				y = arr_pos[1]
				#puts "x: #{x}"
				#puts "y: #{y}"
				curr_dir = direction_arr.shift
				#puts "curr_dir: #{curr_dir}"
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
					#print "next_square "; p next_square
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
		elsif piece.color == 'white'
			until direction_arr.empty?
				x = arr_pos[0]
				y = arr_pos[1]
				curr_dir = direction_arr.shift
				n = 1
				until n == piece.limit + 1
					case curr_dir
					when 'up'
						y -= 1
					when 'down'
						y += 1
					when 'left'
						x -= 1
					when 'right'
						x += 1
					when 'up-left'
						x -= 1
						y -= 1
					when 'up-right'
						x += 1
						y -= 1
					when 'down-left'
						x -= 1
						y += 1
					when 'down-right'
						x += 1
						y += 1
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
		end
		moves = pretty_moves(moves)
	end

	def pretty_moves(moves_arr)
		pretty_arr = []
		moves_arr.each do |pair|
			pretty_arr << arr_to_board(pair)
		end
		pretty_arr
	end

	
















end