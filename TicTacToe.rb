
module TicTacToe
	
	class Cell
		attr_accessor :value
		def initialize(value=' ')
			@value = value
		end
	end
	
	class View
		attr_accessor :grid, :example_grid
		def grid
			puts "|#{$start.lt.value}|#{$start.mt.value}|#{$start.rt.value}|"
			puts "|#{$start.lm.value}|#{$start.mm.value}|#{$start.mr.value}|"
			puts "|#{$start.lb.value}|#{$start.mb.value}|#{$start.rb.value}|"
		end
		def example_grid
			puts "|1|2|3|"
			puts "|4|5|6|"
			puts "|7|8|9|"
		end
	end

	
	class Player
		 attr_writer :taken_cells
		 attr_reader :winner, :name
		def initialize(name, marker)
			@@win = [[1,2,3],[4,5,6],[7,8,9],[1,4,7],[2,5,8],[3,6,9],[1,5,9],[3,5,7]]
			@@taken_cells = []
			@name = name
			@marker = marker
			@cells = []
			@winner = false
			
		end
		
		def place_marker(space)
			space.value = @marker
		end

		def take_turn
			puts "#{@name} choose a space to put your mark:"
			mark = gets.chomp.to_i
			while @@taken_cells.include?(mark)
				puts "Sorry, that space is already taken, try again:"
				mark = gets.chomp.to_i
			end 
				self.place_marker($start.numbertovariable[mark])
				check_for_win(mark)

		end

		def check_for_win(mark)
			@cells.push(mark)
			@@taken_cells.push(mark)
			@cells.sort
			@@win.each do |i|
				intersection = i & @cells
				if intersection.length == 3
					@winner = true
					return true
				end
			end
		end
		
		def declare_winner
			if $player1.winner
				puts "#{$player1.name} WINS!!!"
			elsif $player2.winner
				puts "#{$player2.name} WINS!!!"
			else
				puts "Cat's Game! Nobody wins!"
			end
		end

		def play
			write = TicTacToe::View.new
			write.example_grid
			counter = 0
			until $player1.winner || $player2.winner || counter == 9
				$player1.take_turn
				counter += 1
				write.grid
				if $player1.winner || counter == 9
					break
				else
					$player2.take_turn
					counter += 1
					write.grid
				end
			end
			$player1.declare_winner
		end
	end

	
	class EmptyGame
		attr_accessor :lt,:mt,:rt,:lm,:mm,:mr,:lb,:mb,:rb, :player1, :player2
		attr_reader :numbertovariable
		def initialize
			@lt = TicTacToe::Cell.new
			@mt = TicTacToe::Cell.new
			@rt = TicTacToe::Cell.new
			@lm = TicTacToe::Cell.new
			@mm = TicTacToe::Cell.new
			@mr = TicTacToe::Cell.new
			@lb = TicTacToe::Cell.new
			@mb = TicTacToe::Cell.new
			@rb = TicTacToe::Cell.new

			@numbertovariable = {
				1 => @lt, 2 => @mt, 3 => @rt, 4 => @lm, 
				5 => @mm, 6 => @mr, 7 => @lb, 8 => @mb, 9 => @rb
			}
			$player1 = TicTacToe::Player.new("Player 1", :X)
			$player2 = TicTacToe::Player.new("Player 2", :O)
		end
	end
end

$start = TicTacToe::EmptyGame.new
$player1.play
