class Game
	def start
		@board = Board.new
		puts "let's play some chess BABY"
		puts "player 1 what's your name?"
		name1 = gets.chomp
		puts "you're black"
		@player1 = Player.new(name1, 'black')
		@board.make_pieces(@player1)
		sleep(0.5)
		puts "player 2 what's your name?"
		name2 = gets.chomp
		puts "you're white"
		@player2 = Player.new(name2, 'white')
		sleep(0.5)
		
		puts "here's the board!"
		sleep(1)
		@board.show

	end

	def populate_board

	end

	

	def play
		start
	end
end