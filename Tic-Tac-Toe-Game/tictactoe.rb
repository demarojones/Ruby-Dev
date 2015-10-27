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
	@current_player
	def initialize(curr_players)
		@current_players = curr_players
		@current_player = @current_players[0]
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
	
	def next_player
		if(@current_player == @current_players[0])
			curr_player = @current_players[1]
		else
			curr_player = @current_players[0]
		end
		return curr_player
	end
	
	def size
		@game_board.length
	end
	
	def winner?
		win = check_horizontal_lines
		if(win)
			return win
		end
		win = check_vertical_lines
		if(win)
			return win
		end
		if(win)
			return win
		end
		win = check_diagonal_lines
		if(win)
			return win
		end
		return
	end
	#*****Privates******#
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

	def check_horizontal_lines
		winner = false
		for i in 0..MAX_INDEX
			if @game_board[0][i] == @current_player.marker && @game_board[1][i] == @current_player.marker && @game_board[2][i] == @current_player.marker
				puts "#{@current_player.name}, is the Winner!!"
				winner = true
			end
		end
		return winner
	end

	def check_vertical_lines
		winner = false
		for i in 0..MAX_INDEX
			if @game_board[i][0] == @current_player.marker && @game_board[i][1] == @current_player.marker && @game_board[i][2] == @current_player.marker
				puts "#{@current_player.name}, is the Winner!!"
				winner = true
			end
		end
		return winner
	end

	def check_diagonal_lines
		init_sym = @game_board[0][0]
		for idx in 1..MAX_INDEX
			if(init_sym != @game_board[idx][idx])
				break
			elsif idx == MAX_INDEX and init_sym != PLACEHOLDER
				return init_sym
			end
		end
		init_sym = @game_board[0][MAX_INDEX]
		row_idx = 0
		col_idx = MAX_INDEX
		while row_idx < MAX_INDEX
			row_idx = row_idx + 1
			col_idx = col_idx - 1
			if init_sym != @game_board[row_idx]
				break
			elsif row_idx == MAX_INDEX and init_sym != PLACEHOLDER
				return init_sym
			end
		end
		return false
	end
end

class Game
	@arr_players = []
	def initialize(player_name_1, player_name_2)
		@players = [player_name_1, player_name_2]
	end

	def play_game(player_name)
		if is_valid_player(player_name)
			puts "#{player_name} is a valid player"
			player_idx = get_player_index(player_name)
			puts "#{@players[player_idx]} is a valid player with index #{player_idx}"
			player_o = Player.new(@players[player_idx],"O")
			puts "#{player_o.name} is player O"
			if player_idx == 0
				nm = @players[1]
			else
				nm = @players[0]
			end
			puts "The X player is #{nm}"
			player_x = Player.new(nm, "X")
			@arr_players = [player_o, player_x]
			puts "#{@arr_players}"
		end
		@current_player = @arr_players[0]
		
		puts "The current player is #{@current_player}"
		board = GameBoard.new(@arr_players)
		puts "right before while loop! #{board}"
		until board.winner? or board.full?
			puts "until loop!"
			board.get_player_move(@current_player)
			@current_player = board.next_player()
			board.display()
			puts
		end
#
	end
	

	private 

	def is_winner()
		
	end
	
	def is_valid_player(p_name)
		@players.include? p_name
	end
	
	def get_player_index(player_name)
		@players.index{|p| p==player_name}
	end
end

puts gm = Game.new("mike","david")

gm.play_game("david")

#gb = GameBoard.new()
#puts gb.display()