require_relative 'game.rb'
require_relative 'player.rb'
require_relative 'board.rb'
require_relative 'piece.rb'
require_relative 'pawn.rb'
require_relative 'rook.rb'
require_relative 'knight.rb'
require_relative 'bishop.rb'
require_relative 'king.rb'
require_relative 'queen.rb'



player1 = Player.new("the weeknd", "black")

#player1.list_pieces
player2 = Player.new("demany", "white")
#player2.list_pieces
#board = Board.new
#p board.all_moves(player1.pieces).sort

game = Game.new
#game.castle_start_white_both
game.play
#under_threat = game.all_moves(player1.pieces)
#player1.pieces['rook_2'].moved_yet = true
#p game.can_castle?(player2,under_threat)
