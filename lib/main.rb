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

=begin
game = Game.new
game.play
=end

player1 = Player.new("the weeknd", "black")

#player1.list_pieces
player2 = Player.new("demany", "white")
#player2.list_pieces


game = Game.new
game.play
=begin
pawn = Pawn.new('d5','black')
board.field[3][4] = pawn
new_pawn = Pawn.new('c6','white')
board.field[2][5] = new_pawn

queen = Queen.new('d5','black')
board.field[3][4] = queen
new_pawn = Pawn.new('d6','black')
board.field[3][5] = new_pawn
=end

=begin
knight = Knight.new('c4','black')
board.field[2][3] = knight


rook = Rook.new('a1','black')
board.field[0][0] = rook

board.show
moves = board.valid_moves(rook)
p moves
#p board.pretty_moves(moves)


board.populate(player1.pieces)
board.populate(player2.pieces)

player1.pieces.each do |name, piece|
	puts name
	puts "\t#{piece.pos}"
	puts "\t#{piece.color}"
	puts "\t#{piece.sym}"
	puts "\t#{piece.direction}"
	puts "\t#{piece.limit}"
end
=end
#board.show
#p board.field
#p board.field[0][1].color


