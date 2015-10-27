
class Player
	attr_accessor :name, :marker

	def initialize(name, marker=nil)
		@name = name
		@marker = marker
	end
end

class GameBoard
	MAX_INDEX = 2
	PLACEHOLDER = "__"

	def initialize()
		@game_board = create_board()
	end

	def display
		puts "*** GAME BOARD ***"
		for row in 0..MAX_INDEX
			print "    "
			for column in 0..MAX_INDEX
				pos_val = @game_board[row][column]
				if pos_val == PLACEHOLDER
					print PLACEHOLDER
				else
					print pos_val
				end
				print " "
			end
			puts "\n"
		end
	end
	
	def full?
		for row in 0..MAX_INDEX
			for column in 0..MAX_INDEX
				if @game_board[row][column] == PLACEHOLDER
					return false
				end
			end
		end
		return true
	end

	private 
	def create_board
		Array.new(MAX_INDEX+1){
			Array.new(MAX_INDEX+1){PLACEHOLDER}
		}
	end

	def validate_move(row,col)
		if row <= @game_board.size and col <= @game_board.size
			if @game_board[row][col] == PLACEHOLDER
				return true
			else
				puts "Dude, what board are you looking at? Try again"
			end
		else
			puts "Umm OK, you wanna check the instructions again?"
		end
		return false
	end

	def check_horizontal_line
		for i in 0..MAX_INDEX
			if @game_board[0][i] == @current_player.marker && @game_board[1][i] == @current_player.marker && @game_board[2][i] == @current_player.marker
				puts "#{current_player.name}, is the Winner!!"
			end
		end
	end

	def check_vertical_line
		for i in 0..MAX_INDEX
			if @game_board[i][0] == @current_player.marker && @game_board[i][1] == @current_player.marker && @game_board[i][2] == @current_player.marker
				puts "#{current_player.name}, is the Winner!!"
			end
		end
	end

	def check_diagonal_line

	end
end

class Game
	MAX_INDEX = 3
	PLACEHOLDER = "__"
	attr_reader :players, :current_player, :board	

	def initialize(player_1, player_2)
		@players = [player_name_1, player_name_2]
	end

	def play_game(player_name)
		current_player = players.each{|p| 
			if p == player_name
				players[0] = Player.new(player_name)
				return p
			end
		} 

		until board.winner? or board.full?
			get_player_move(current_player)
			current_player = nextPlayer()
		end
	end

	def get_player_move(current_player)
		played = false
		while not played
			puts "#{current_player.name}, enter your next #{current_player.marker} move (1-9): "

			move = gets.to_i - 1
			colmn = move % board.size
			row = (move - col)/board.size
			if validate_move(row, colmn)
				board[row][colmn] = current_player.marker
				played = true
			end
		end
	end

	private 
	def get_current_player

	end

	def isWinner()

	end
end

gb = GameBoard.new
puts gb.display()