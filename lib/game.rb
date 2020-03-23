class Game
	def start
		@board = Board.new
		puts "let's play some chess BABY"
		sleep(0.7)
		puts "player 1 what's your name?"
		name1 = gets.chomp
		puts "you're black"
		@player1 = Player.new(name1, 'black')
		@board.update(@player1.pieces)
		sleep(0.5)

		puts "player 2 what's your name?"
		name2 = gets.chomp
		puts "you're white"
		@player2 = Player.new(name2, 'white')
		@board.update(@player2.pieces)
		sleep(0.5)
		
		puts "here's the board!"
		sleep(1)
		@board.show
	end

	def test_start
		@board = Board.new
		@player1 = Player.new("the weeknd", 'black')
		@board.update(@player1.pieces)
		@player2 = Player.new("demany", 'white')
		@board.update(@player2.pieces)
		@board.show
	end

	def get_chosen_arr(player)
		while 1
			puts "which piece do you want to move?"
			choice = gets.chomp.downcase
			if valid_piece_name?(choice)
				chosen_hash = {}
				no_moves = false
				player.pieces.each do |piece_name,piece_object|
					#print "piece_name, piece"; p piece_name; p piece_object;
					if piece_name =~ /#{choice}/ # if you have one of those pieces (ex if you have at least one pawn)
						moves = @board.valid_moves(piece_object)
						if moves.empty? # check if chosen piece can even move anywhere		
							no_moves = true
						else
							
							chosen_hash[piece_object.pos] = piece_name # if it can, put it in chosen_hash, but if not player will be prompted for another choice
						end
					end
				end
				print "chosen_hash "; p chosen_hash
				puts ""
				if chosen_hash.length > 0 
					break
				elsif chosen_hash.empty? && no_moves
					puts "your #{choice} has nowhere to move :( choose a different piece"
				else 
					puts "you don't have any #{choice}s :( choose a different piece"
					sleep(0.7)
				end
			else
				puts "enter a valid piece name. you know what they are -__-"
				sleep(0.7)
			end
		end

		return chosen_hash, choice
	end

	def choose_piece(chosen_hash,choice)
		while 1
			puts "there are #{choice}s at "
			chosen_hash.keys.each {|k| print "#{k} "}
			puts ""

			puts "which #{choice} do you want to move?"
			pos = gets.chomp.downcase
			if valid_pos_name?(pos)
				if chosen_hash.keys.any? { |k| k == pos }
					break
				else
					puts "you don't have a #{choice} on that square :("
					sleep(0.5)
				end	
			else
				puts "that's not a valid position :( try again"
				sleep(0.7)
			end
		end
		pos
	end

	def get_destination(board_moves,choice)
		while 1
			puts "where would you like to move your #{choice}?"
			destination = gets.chomp.downcase
			if board_moves.any? { |move| move == destination }
				break
			else
				puts "your #{choice} can't move there :("
				sleep(0.5)
			end
		end
		destination
	end


	def turn(player,other_player)
		@board.show
		puts "#{player.name}, your move!"
		sleep(0.5)
		chosen_arr = get_chosen_arr(player) # this function is where player inputs piece that they want to move
		chosen_hash = chosen_arr[0] # this is hash of the locations of the piece's that match the player's choice (ex all their pawns) and the names of those pieces as stored in player.pieces array
		choice = chosen_arr[1] # this is the name of the piece type (ex pawn)
		#print "chosen_hash"; p chosen_hash
		if chosen_hash.length > 1
			pos = choose_piece(chosen_hash,choice)
		else
			pos = chosen_hash.values[0]
		end
		piece_name = chosen_hash[pos]
		piece = player.pieces[piece_name]
		arr_moves = @board.valid_moves(piece) # array containing piece's possible moves in array format [0,0]
		board_moves = @board.pretty_moves(arr_moves) # array containing possible moves in board format "a1"
		destination = get_destination(board_moves,choice)

		taken_piece = @board.move_piece(piece,destination)
		if taken_piece
			taken_piece_name = other_player.pieces.key(taken_piece)
			other_player.pieces.delete(taken_piece_name)
		end

	end

	def valid_piece_name?(input)
		names = ["pawn","rook","knight","bishop","queen","king"]
		return true if names.any? { |n| n == input}
		false
	end

	def valid_pos_name?(pos)
		return true if pos.length == 2 && (pos[0] >= "a" && pos[0] <= "h") && (pos[1].to_i >= 1 && pos[1].to_i <= 8)
		false
	end

	def test_taking_piece
		piece1 = @player2.pieces["w_pawn_2"]
		@board.move_piece(piece1, "b5")
		piece2 = @player1.pieces["b_pawn_1"]
		@board.move_piece(piece2, "a4")
	end

	def play
		test_start
		#test_taking_piece
		while 1
			turn(@player1,@player2)
			turn(@player2,@player1)
		end

		
=begin
		puts "player"
		p @player1
		puts "\n\n\n\n"
		#p @player2
		puts "board.field"
		p @board.field
		puts "\n\n\n\n"
		@player1.pieces.delete("b_rook_1")
		puts "rook deleted"
		puts "player"
		p @player1
		puts "\n\n\n\n"

		puts "board.field"
		p @board.field
=end
		#turn(@player1)
	end
end