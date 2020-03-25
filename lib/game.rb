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

	def castle_start_black_left
		@board = Board.new
		@player1 = Player.new("the weeknd", 'black')
		@player1.pieces.delete("knight_1")
		@player1.pieces.delete("bishop_1")
		@board.update(@player1.pieces)
		@player2 = Player.new("demany", 'white')
		@board.update(@player2.pieces)
		@board.show
	end

	def castle_start_black_right
		@board = Board.new
		@player1 = Player.new("the weeknd", 'black')
		@player1.pieces.delete("knight_2")
		@player1.pieces.delete("bishop_2")
		@player1.pieces.delete("queen")
		@board.update(@player1.pieces)
		@player2 = Player.new("demany", 'white')
		@board.update(@player2.pieces)
		@board.show
	end	

	def castle_start_black_both
		@board = Board.new
		@player1 = Player.new("the weeknd", 'black')
		@player1.pieces.delete("knight_1")
		@player1.pieces.delete("bishop_1")
		@player1.pieces.delete("knight_2")
		@player1.pieces.delete("bishop_2")
		@player1.pieces.delete("queen")
		@board.update(@player1.pieces)
		@player2 = Player.new("demany", 'white')
		@board.update(@player2.pieces)
		@board.show
	end	

	def castle_start_white_left
		@board = Board.new
		@player1 = Player.new("the weeknd", 'black')
		@board.update(@player1.pieces)
		@player2 = Player.new("demany", 'white')
		@player2.pieces.delete("knight_1")
		@player2.pieces.delete("bishop_1")
		@board.update(@player2.pieces)
		@board.show
	end

	def castle_start_white_right
		@board = Board.new
		@player1 = Player.new("the weeknd", 'black')
		@board.update(@player1.pieces)
		@player2 = Player.new("demany", 'white')
		@player2.pieces.delete("knight_2")
		@player2.pieces.delete("bishop_2")
		@player2.pieces.delete("queen")
		@board.update(@player2.pieces)
		@board.show
	end	

	def castle_start_white_both
		@board = Board.new
		@player1 = Player.new("the weeknd", 'black')
		@board.update(@player1.pieces)
		@player2 = Player.new("demany", 'white')
		@player2.pieces.delete("knight_1")
		@player2.pieces.delete("bishop_1")
		@player2.pieces.delete("knight_2")
		@player2.pieces.delete("bishop_2")
		@player2.pieces.delete("queen")
		@board.update(@player2.pieces)
		@board.show
	end	

	def get_chosen_arr(player,other_player)
		while 1
			puts "which piece do you want to move?"
			choice = gets.chomp.downcase
			if valid_piece_name?(choice)
				if choice == 'king'
					if king_has_moves(player,other_player)
						king_object = player.pieces['king']
						chosen_hash = {king_object.pos => 'king'}
						break
					else
						puts "your king has nowhere to move! choose a different piece"
					end
				else
					chosen_hash = {}
					
					player.pieces.each do |piece_name,piece_object|
						#print "piece_name, piece"; p piece_name; p piece_object;
						if piece_name =~ /#{choice}/ # if you have one of those pieces (ex if you have at least one pawn)
							chosen_hash[piece_object.pos] = piece_name # if it can, put it in chosen_hash, but if not player will be prompted for another choice
						end
					end
					#print "chosen_hash "; p chosen_hash
					#puts ""
					if chosen_hash.length > 0 
						valid_pieces = []
						chosen_hash.values.each do |piece_name|
							piece = player.pieces[piece_name]
							moves = @board.valid_moves(piece)
							if !moves.empty? #if piece has moves put its name in valid_pieces array
								valid_pieces << piece_name
							end
						end
						if !valid_pieces.empty? # if there's at least one valid piece, move on
							break
						else
							puts "none of your #{choice}s have anywhere to move :( choose a different piece!"
						end
					elsif chosen_hash.empty? && no_moves
						puts "your #{choice} has nowhere to move :( choose a different piece"
					else 
						puts "you don't have any #{choice}s :( choose a different piece"
						sleep(0.7)
					end
				end
			else
				puts "enter a valid piece name. you know what they are -__-"
				sleep(0.7)
			end
		end

		return chosen_hash, choice
	end

	def choose_piece(chosen_hash,choice,pieces_hash)
		while 1
			puts "you have #{choice}s at "
			chosen_hash.keys.each {|k| print "#{k} "}
			puts ""

			puts "which #{choice} do you want to move?"
			pos = gets.chomp.downcase
			if valid_pos_name?(pos)
				if chosen_hash.keys.any? { |k| k == pos } # do you have this piece at that pos
					piece_name = chosen_hash[pos]
					moves = @board.valid_moves(pieces_hash[piece_name])
					if !moves.empty? # if piece has moves
						break
					else
						puts "that #{choice} has nowhere to move :("
					end
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

	def all_moves(pieces_hash)
		pieces = pieces_hash.values
		moves_arr = []
		pieces.each do |piece|
			piece_moves = @board.valid_moves(piece)
			moves_arr << piece_moves
		end
		moves_arr.flatten.uniq.sort
	end

	def can_castle?(player,under_threat)
		if player.color == 'black'
			y = 0
		elsif player.color == 'white'
			y = 7
		end

		king = player.pieces['king']
		unmoved_rooks = []
		player.pieces.each do |piece_name,piece_object|   # make array of rooks that haven't moved yet
			if piece_name =~ /rook/ && !piece_object.moved_yet
				unmoved_rooks << piece_name
			end
		end
		#print "king "; p king
		#print "unmoved_rooks "; p unmoved_rooks
		clear_rooks = []
		if !king.moved_yet && !unmoved_rooks.empty? && !player.check # if king hasn't moved yet, at least one rook hasn't moved, and king is not in check
			unmoved_rooks.each do |rook|
				#print "rook "; p rook
				clear_path = false
				if rook[-1] == "1"
					cols = [1,2]
				elsif rook[-1] == "2"
					cols = [4,5,6]
				end
				cols.each do |x|
					#print "[x,y]"; p [x,y]
					board_square = @board.arr_to_board([x,y])
					if !@board.occupied([x,y]) && under_threat.none? { |threat| threat == board_square } # if square is unoccupied and not under threat
						clear_path = true
					else
						clear_path = false
					end
				end
				clear_rooks << rook if clear_path
			end
			#print "clear_rooks"; p clear_rooks
			return clear_rooks
		else
			return false
		end
	end

	def castle(player, rooks_arr)
		if rooks_arr.length > 1 # there two rooks you can castle with
			pos_1 = player.pieces[rooks_arr[0]].pos
			pos_2 = player.pieces[rooks_arr[1]].pos
			y = pos_1[1]
			puts "you can castle with your rook at #{pos_1} or your rook at #{pos_2}"
			puts "which one?"
			while 1
				choice = gets.chomp.downcase
				if valid_pos_name?(choice)
					if choice == pos_1 || choice == pos_2
						break
					else
						puts "you don't have a rook there that you can castle with :( choose again"
						sleep(0.7)
					end
				else
					puts "that's not a valid position :( try again"
					sleep(0.7)
				end
			end
			if choice[0] == 'a'
				rook = rooks_arr[0]
			elsif choice[0] == 'h'
				rook = rooks_arr[1]
			end
		else
			rook = rooks_arr[0]
		end
		king_piece = player.pieces['king']
		rook_piece = player.pieces[rook]
		if rook[-1] == '1' # if rook on left
			@board.move_piece(king_piece, "b#{y}")
			@board.move_piece(rook_piece, "c#{y}")
		elsif rook[-1] == '2'
			@board.move_piece(king_piece, "f#{y}")
			@board.move_piece(rook_piece, "e#{y}")
		end
	end

	def get_destination(board_moves,choice,player,other_player)
		
		puts "where would you like to move your #{choice}?"
		if choice == 'king'
			under_threat = all_moves(other_player.pieces)
			can_castle = can_castle?(player,under_threat)
			if can_castle
				puts "you can castle! if you'd like to castle, input \"castle\""
			end
		end

		while 1
			#print "board_moves "; p board_moves
			destination = gets.chomp.downcase

			if valid_pos_name?(destination) # if your input is formatted correctly
				if board_moves.any? { |move| move == destination } # if your input is one of the piece's moves
					if choice == 'king'
						if under_threat.any? { |square| square == destination }
							puts "king can't move there because that square is under threat of attack!"
						else
							break
						end
					else
						break
					end
				else
					puts "your #{choice} can't move there :("
					sleep(0.5)
				end
			elsif destination == 'castle' && can_castle
				return can_castle
				break
			else
				puts "that's not a valid position :( try again"
				sleep(0.7)
			end
		end
		destination
	end

	def simplify_name(given_name)
		if given_name =~ /queen/ || given_name =~ /king/
			simple_name = given_name
		else
			simple_name = given_name[0..-3]
		end
		return simple_name
	end

	def turn(player,other_player)
		puts "#{player.name}, your move!"
		if player.check # if player is in check
			piece = player.pieces["king"]
			choice = "king"
			puts "you have no choice but to move your king!"
		else
			chosen_arr = get_chosen_arr(player,other_player) # this function is where player inputs piece that they want to move
			chosen_hash = chosen_arr[0] # this is hash of the locations of the piece's that match the player's choice (ex all their pawns) and the names of those pieces as stored in player.pieces array
			#print "chosen_hash"; p chosen_hash
			choice = chosen_arr[1] # this is the name of the piece type (ex pawn)
			#print "chosen_hash"; p chosen_hash
			if chosen_hash.length > 1
				pos = choose_piece(chosen_hash,choice,player.pieces)
			else
				pos = chosen_hash.keys[0]
			end
			#print "pos"; p pos
			piece_name = chosen_hash[pos]
			piece = player.pieces[piece_name]
		end
		board_moves = @board.valid_moves(piece) # array containing possible moves in board format "a1"
		#print "arr_moves"; p arr_moves
		#print "board_moves"; p board_moves
		destination = get_destination(board_moves,choice,player,other_player)
		if destination.is_a? Array
			castle(player,destination)
			taken_piece = nil
			#print "destination "; p destination
		else
			taken_piece = @board.move_piece(piece,destination)
		end
		
		#print "taken_piece "; p taken_piece
		if taken_piece
			taken_piece_name = other_player.pieces.key(taken_piece)
			other_player.pieces.delete(taken_piece_name)
			piece_name = simplify_name(taken_piece_name)
			puts "#{other_player.name}! #{player.name} captured your #{piece_name}!"
			sleep(1)
		end
		@board.show
		if check?(other_player,player) #check if you put opponent's king in check
			other_player.check = true
			puts "#{other_player.name}, CHECK!"
			sleep(0.7)
		end
		
	end

	def check?(player,other_player)
		king = player.pieces["king"]
		#print "king: "; p king
		king_at = king.pos
		under_threat = all_moves(other_player.pieces)
		#print "under_threat"; p under_threat
		if under_threat.any? { |square| square == king_at } # if king's location is under attack
			player.check = true
			return true
		else
			player.check = false
			false
		end
	end

	def king_has_moves(player,other_player)
		has_moves = true
		king = player.pieces["king"]
		king_at = king.pos
		king_moves = @board.valid_moves(king)
		cant_go = []
		#print "king_moves "; p king_moves
		under_threat = all_moves(other_player.pieces)
		#print "under_threat"; p under_threat
		king_moves.each_with_index do |king_move, idx|
			if under_threat.any? { |square| square == king_move }
				cant_go << king_move
			end
		end
		has_moves = false if king_moves.length == cant_go.length
		has_moves
	end

	def checkmate?(player,other_player)
		#puts "check?: #{player.check}"
		return checkmate = true if player.check && !king_has_moves(player,other_player)
		false
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

	def test_setup
		w_pawn_4 = @player2.pieces["pawn_4"]
		@board.move_piece(w_pawn_4, "d5")
		b_pawn_4 = @player1.pieces["pawn_4"]
		b_pawn_5 = @player1.pieces["pawn_5"]
		@board.move_piece(b_pawn_4, "d4")
		@board.move_piece(b_pawn_5, "e4")
		b_queen = @player1.pieces["queen"]
		b_bishop = @player1.pieces["bishop_2"]
		@board.move_piece(b_queen, "a5")
		w_queen = @player2.pieces["queen"]
		@board.move_piece(w_queen, "a4")
		@board.move_piece(b_queen, "b5")
		@board.move_piece(b_queen, "d5")
		#@board.move_piece(b_bishop, "b5")
	end

	def play
		castle_start_black_both
		#test_setup
		#@board.show
		#p check?(@player2,@player1)
		#print "checkmate? "; p checkmate?(@player2,@player1)
		#p @player1.pieces
		while 1
			if checkmate?(@player1,@player2) # player 1 is in checkmate
				winner = @player2
				break
			end
			turn(@player1,@player2)
			if checkmate?(@player2,@player1) # player 2 is in checkmate
				
				winner = @player1
				break
			end
			turn(@player2,@player1)
		end
		puts "and CHECKMATE!!"
		sleep(1)
		puts "#{winner.name} is VICTORIOUS!!!"

		
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