
#Player Class
class Player
	attr_accessor :name, :marker

	def initialize(name, marker=nil)
		@name = name
		@marker = marker
	end
end




#GameBoad Class
class GameBoard
	MAX_INDEX = 2
	PLACEHOLDER = "_"

	def initialize(current_plyr)
		@current_player = current_plyr
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
	
	def get_player_move(current_player)
		@current_player = current_player
		played = false
		while not played
			puts "#{current_player.name}, enter your next #{current_player.marker} move (1-9): "
			move = gets.to_i - 1
			colmn = move % @game_board.size
			row = (move - colmn)/@game_board.size
			if validate_move(row, colmn)
				@game_board[row][colmn] = current_player.marker
				played = true
			end
		end
	end
	
	def size
		@game_board.length
	end
	
	def winner_found?
		check_for_winner
	end

	def player
		@current_player
	end

	#*****Private parts******#
	private 
	def create_board
		Array.new(MAX_INDEX+1){
			Array.new(MAX_INDEX+1){PLACEHOLDER}
		}
	end

	def validate_move(row,col)
		if row < @game_board.size and col < @game_board.size
			if @game_board[row][col] == PLACEHOLDER
				return true
			else
				puts "Dude, The space is already taken, Try again"
			end
		else
			puts "That number is out of range, Please enter a number from 1-9!"
		end
		return false
	end

	def check_for_winner
		winning_combo = @current_player.marker * (MAX_INDEX+1)
		diag_1=""
		diag_2=""
		init_sym = @game_board[0][0] #From top Left
		for idx in 0..MAX_INDEX
			diag_1 += @game_board[idx][idx]
			diag_2 += @game_board[idx][MAX_INDEX - idx]
			if((@game_board[0][idx] + @game_board[1][idx] + @game_board[2][idx])== winning_combo)
				return true
			elsif (@game_board[idx][0] + @game_board[idx][1] + @game_board[idx][2])== winning_combo
				return true
			end
		end
		if diag_1 == winning_combo or diag_2 == winning_combo
				return true
		end
		return false
	end
end #End Class 'GameBoard'


#Game Class
class Game
	@arr_players = []
	def initialize(player_1, player_2)
		@players = [player_1.capitalize, player_2.capitalize]
	end

	def play_game(player_name)
		if is_valid_player(player_name.capitalize)
			player_idx = get_player_index(player_name)
			player_o = Player.new(@players[player_idx],"O")
			if player_idx == 0
				nm = @players[1]
			else
				nm = @players[0]
			end
			player_x = Player.new(nm, "X")
			@arr_players = [player_o, player_x]
		else
			puts "Umm, Who are you?... Please try again..."
			return
		end
		@current_player = @arr_players[0]
		
		board = GameBoard.new(@current_player)
		until board.winner_found? or board.full?
			board.get_player_move(@current_player)
			@current_player = next_player()
			board.display()
			puts
		end

		if board.winner_found?
			puts "#{board.player.name}, you won!!!"
		elsif board.full?
			puts "It's a Tie!!!"
		end
			
	end
	

	private 
	def next_player
		if(@current_player == @arr_players[0])
			curr_player = @arr_players[1]
		else
			curr_player = @arr_players[0]
		end
		return curr_player
	end
	
	def is_valid_player(p_name)
		@players.include? p_name
	end
	
	def get_player_index(player_name)
		@players.index{|p| p==player_name}
	end
end

gm = Game.new("lindsay","jolie")
gm.play_game("Jolie")
