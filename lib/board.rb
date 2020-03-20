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
end