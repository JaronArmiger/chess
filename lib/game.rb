class Game
	def start
		@board = Board.new
		puts "let's play some chess BABY"
		sleep(0.7)
		puts "player 1 what's your name?"
		name1 = gets.chomp
		puts "you're black"
		@player1 = Player.new(name1, 'black')
		@board.populate(@player1.pieces)
		sleep(0.5)

		puts "player 2 what's your name?"
		name2 = gets.chomp
		puts "you're white"
		@player2 = Player.new(name2, 'white')
		@board.populate(@player2.pieces)
		sleep(0.5)
		
		puts "here's the board!"
		sleep(1)
		@board.show
	end

	def test_start
		@board = Board.new
		@player1 = Player.new("the weeknd", 'black')
		@board.populate(@player1.pieces)
		@player2 = Player.new("demany", 'white')
		@board.populate(@player2.pieces)
		@board.show
	end

	def turn(player)
		@board.show
		puts "#{player.name}, your move!"
		sleep(0.5)
		while 1
			puts "which piece do you want to move?"
			piece = gets.chomp.downcase
			if valid_piece_name?(piece)
				if player.pieces.keys.any? { |name| name =~ /#{piece}/ }
					puts "okay! you have that piece"
					chosen_hash = {}
					player.pieces.each do |piece_name,piece_object|
						if piece_name =~ /#{piece}/
							#print "piece_name, piece"; p piece_name; p piece;
							chosen_hash[piece_name] = piece_object.pos
						end
					end
					break
				else
					puts "you don't have that piece :( choose a different one"
				end
			else
				puts "enter a valid piece name. you know what they are -__-"
				sleep(0.7)
			end
		end
		p chosen_hash
	end

	def valid_piece_name?(input)
		names = ["pawn","rook","knight","bishop","queen","king"]
		return true if names.any? { |name| name == input}
		false
	end

	

	def play
		test_start
		turn(@player1)
	end
end