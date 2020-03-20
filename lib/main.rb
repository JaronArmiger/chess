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


game = Game.new
game.play
=begin
player1 = Player.new("the weeknd", "black")
#player1.list_pieces
player2 = Player.new("demany", "white")
#player2.list_pieces

board = Board.new

board.populate(player1.pieces)
board.populate(player2.pieces)
board.show
=end
=begin

pawn_b = Pawn.new("A4", 'black')
pawn_w = Pawn.new("A4", 'white')

rook_b = Rook.new("A4", 'black')
rook_w = Rook.new("A4", 'white')

knight_b = Knight.new("A4", 'black')
knight_w = Knight.new("A4", 'white')

bishop_b = Bishop.new("A4", 'black')
bishop_w = Bishop.new("A4", 'white')

queen_b = Queen.new("A4", 'black')
queen_w = Queen.new("A4", 'white')

king_b = King.new("A4", 'black')
king_w = King.new("A4", 'white')


puts "black pawn: #{pawn_b.sym}"
puts "white pawn: #{pawn_w.sym}"

puts "black rook: #{rook_b.sym}"
puts "white rook: #{rook_w.sym}"

puts "black knight: #{knight_b.sym}"
puts "white knight: #{knight_w.sym}"

puts "black bishop: #{bishop_b.sym}"
puts "white bishop: #{bishop_w.sym}"

puts "black queen: #{queen_b.sym}"
puts "white queen: #{queen_w.sym}"

puts "black king: #{king_b.sym}"
puts "white king: #{king_w.sym}"
=end
