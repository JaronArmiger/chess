class Board
	attr_accessor :board
	def initialize
		@board = make_board
	end

	def make_board
		board_arr = []
		8.times do 
			column = []
			8.times do
				column << nil
			end
			board_arr << column
		end
		board_arr
	end

	def make_pieces(player)
		if player.color == 'black'
			pawn_row = 2
			army_row = 1
		elsif player.color = 'white'
			pawn_row = 7
			army_row = 8
		end

		alpha = ["a","b","c","d","e","f","g","h"]
		pre = player.color[0]
		alpha.each_with_index do |letter, idx|
			instance_variable_set("@#{pre}_pawn_#{idx+1}", Pawn.new("#{letter}#{pawn_row}",player.color,player))
		end
		puts "@b_pawn_1"
		p @b_pawn_1
		puts "@b_pawn_2"
		p @b_pawn_2
		puts "@b_pawn_3"
		p @b_pawn_3
		puts "@b_pawn_4"
		p @b_pawn_4
		puts "@b_pawn_5"
		p @b_pawn_5
		puts "@b_pawn_6"
		p @b_pawn_6
		puts "@b_pawn_7"
		p @b_pawn_7
		puts "@b_pawn_8"
		p @b_pawn_8

		instance_variable_set("@#{pre}_rook_1", Rook.new("a#{army_row}",player.color,player))
		instance_variable_set("@#{pre}_rook_2", Rook.new("h#{army_row}",player.color,player))

		instance_variable_set("@#{pre}_knight_1", Knight.new("b#{army_row}",player.color,player))
		instance_variable_set("@#{pre}_knight_2", Knight.new("g#{army_row}",player.color,player))

		instance_variable_set("@#{pre}_bishop_1", Bishop.new("c#{army_row}",player.color,player))
		instance_variable_set("@#{pre}_bishop_2", Bishop.new("f#{army_row}",player.color,player))

		instance_variable_set("@#{pre}_queen", Queen.new("d#{army_row}",player.color,player))

		instance_variable_set("@#{pre}_king", King.new("h#{army_row}",player.color,player))

		puts "@b_rook_1"
		p @b_rook_1
		puts "@b_rook_2"
		p @b_rook_2

		puts "@b_knight_1"
		p @b_knight_1
		puts "@b_knight_2"
		p @b_knight_2

		puts "@b_bishop_1"
		p @b_bishop_1
		puts "@b_bishop_2"
		p @b_bishop_2

		puts "@b_queen"
		p @b_queen

		puts "@b_king"
		p @b_king
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
				if board[row][col].nil?
					print "|   "
				else
					print "| #{board[row][col]} "
				end
			end
			print "|"
			puts ""
			puts line
		end
		puts ""
	end

	def translate_pos(pos)
		letter = pos[0]
		num = pos[1].to_i
		pos_arr = [letter.ord - 97, num - 1]
	end
end