require './mars_plateau'

class MarsRover

	def initialize ( x, y, direction )
		@x = x
		@y = y
		@direction = direction
	end

	attr_reader :x, :y, :direction

	def move()
		case @direction
		when "N"
			@y +=1
		when "E"
			@x +=1
		when "S"
			@y -=1
		when "W"
			@x -=1
		end
	end

	def step_back()
		if @x > MarsPlateau.max_x
			@x -= 1
		elsif @y > MarsPlateau.max_y
			@y -=1
		elsif @x < MarsPlateau.min_x
			@x +=1
		else
			@y +=1
		end
	end

	def change_direction(param)
		case @direction
		when "N" 
			if param == "R" then @direction = "E" else @direction = "W" end
		when "S"
			if param == "R" then @direction = "W" else @direction = "E" end
		when "E"
			if param == "R" then @direction = "S" else @direction = "N" end
		when "W"
			if param == "R" then @direction = "N" else @direction = "S" end
		end
	end


	def to_string
		return "x, y and direction #{@x},#{@y}, #{@direction} \n"
	end


	def execute_commands(commands)
		commands = commands.gsub(/\s+/, "").split("")
		commands.each {|c| execute(c)}
	end


	def execute(command)
		if command == "M"
			move()
			if !@x.between?(MarsPlateau.min_x, MarsPlateau.max_x) or !@y.between?(MarsPlateau.min_y, MarsPlateau.max_y)
				step_back()
				raise "Staying within the grid - Stepping back on plateau"
			end
		elsif command == "L" or command == "R"
			change_direction(command)
		else
			raise "Command #{command} is invalid."
		end
	end
end