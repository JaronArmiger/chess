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

	def translate_pos(pos)
		letter = pos[0]
		num = pos[1].to_i
		pos_arr = [letter.ord - 97, num - 1]
	end

	def populate(pieces_hash)
		pieces_hash.each do |name, piece|
			pos = translate_pos(piece.pos)
			field[pos[0]][pos[1]] = piece.sym
		end
	end
end