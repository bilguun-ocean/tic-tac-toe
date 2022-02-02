class Player
  attr_reader :name, :marker

  @@number_of_players = 0
  @@markers = ['X','O']
  def initialize(name, marker)
    @name = name
    @marker = marker
  end

  def self.create_player()
    puts "Please enter the name of player ##{@@number_of_players.to_i + 1}"
    name = gets.chomp
    @@number_of_players += 1

    if @@number_of_players <= 1
      puts "Would you like to be X or O ?"
      marker = gets.chomp.upcase

      until @@markers.include?(marker)
        puts "Please enter either X or O"
        marker = gets.chomp.upcase
      end
      @@markers.delete(marker)
    else
      puts "#{name} have been chosen to play as #{@@markers[0]} "
      marker = @@markers[0]
    end

    Player.new(name, marker)
  end

  attr_reader
end

#Methods used:

# Method for drawing the board
def draw_board(board)
  puts "#{board[0]}|#{board[1]}|#{board[2]}"
  puts "-+-+-"
  puts "#{board[3]}|#{board[4]}|#{board[5]}"
  puts "-+-+-"
  puts "#{board[6]}|#{board[7]}|#{board[8]}"
end

def make_move(board, letter, move)
  board[move] = letter
end

def is_winner?(bo, le)
  #Across the top
  (bo[0] == le && bo[1] == le && bo[2] == le) ||
  #Across the mid
  (bo[3] == le && bo[4] == le && bo[5] == le) ||
  #Across the bottom
  (bo[6] == le && bo[7] == le && bo[8] == le) ||
  #Across the left
  (bo[0] == le && bo[3] == le && bo[6] == le) ||
  #Across the middle/horizontally
  (bo[1] == le && bo[4] == le && bo[7] == le) ||
  #Across the right
  (bo[2] == le && bo[5] == le && bo[8] == le) ||
  #Diagnol #1
  (bo[0] == le && bo[4] == le && bo[8] == le) ||
  #Diagnol #2
  (bo[2] == le && bo[4] == le && bo[6] == le)
end

def is_space_free?(board, move)
  board[move] == ' '
end

def get_player_move(board, player_name)
  puts "#{player_name} what is your move?"
  move = gets.chomp.to_i

  while (move < 0 || move > 8) || not(is_space_free?(board, move))
    puts "Please enter a valid move"
    move = gets.chomp.to_i
  end
  move
end

def is_tie?(board)
  board.all? {|space| space != " "}
end

def who_goes_first()

end

###Actual game starts from here


player1 = Player.create_player
player2 = Player.create_player


loop do
  game_board = [" "] * 9
  markers = [player1.marker, player2.marker]

  loop do
    #Player1's turn
    draw_board(game_board)
    move = get_player_move(game_board, player1.name)
    make_move(game_board, player1.marker, move)
    if is_winner?(game_board, player1.marker)
      draw_board(game_board)
      puts "HOORAY! #{player1.name} has won the game!"
      break
    elsif is_tie?(game_board)
      draw_board(game_board)
      puts "The game has ended in tie."
      break
    end
    #Player2's turn
    draw_board(game_board)
    move = get_player_move(game_board, player2.name)
    make_move(game_board, player2.marker, move)
    if is_winner?(game_board, player2.marker)
      draw_board(game_board)
      puts "HOORAY! #{player2.name} has won the game!"
      break
    elsif is_tie?(game_board)
      draw_board(game_board)
      puts "The game has ended in tie."
      break
    end
  end
  # Asking for user to continue or end exit the game
  puts "Would you like to play again? (yes or no)"
  play_again = gets.chomp
  unless play_again.downcase.chr == 'y'
    break
  end  
end