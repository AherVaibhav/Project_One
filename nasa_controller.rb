require "./mars_rover"
require "./mars_plateau"

class NasaController

	def initialize(input)
		@input = input
	end

	def validate_rovers_commands # make sure commands are proper before rovers start executing them
		@input.each do | c |
			c.strip!
			raise "unsupported command |#{c}| \n" unless c =~ /\A\d{1} \d{1}+\z/ || c =~ /\A\d{1} \d{1} (E|W|N|S)+\z/ \
				|| c =~ /\A(L|R|M)+\z/
		end
	end

	def start_rovers_commands
		@input.each do | c |
			c.strip!
			if c.length == 3 && (c =~ /\A(L|R|M)+\z/).nil? # a three character move command is legit, but it does not belong here
				initiate_grid(c)
			elsif c.length == 5 && (c =~ /\A(L|R|M)+\z/).nil? # a five character move command is legit, but it does not belong here
				initiate_rover(c)
			else
				move_rover(c)
			end
		end
	end


	private

	def initiate_grid(c)
		c = c.gsub(/\s+/, "").split("")
		MarsPlateau.new(c[0].to_i, c[1].to_i, 0, 0); #initiate plateau 
	end

	def initiate_rover(c)
		c = c.gsub(/\s+/, "").split("")
		unless c[0].to_i.between?(MarsPlateau.min_x, MarsPlateau.max_x) and c[1].to_i.between?(MarsPlateau.min_y, MarsPlateau.max_y)
			raise "starting coordinates of rover are not on grid"
		end
		initiated_rover = MarsRover.new(c[0].to_i, c[1].to_i, c[2])
		MarsPlateau.rovers.push(initiated_rover)
	end

	def move_rover(c)
		rover_in_action = MarsPlateau.rovers.pop
		begin
			rover_in_action.execute_commands(c)
			MarsPlateau.rovers.push(rover_in_action)
		rescue Exception => e
			MarsPlateau.rovers.push(rover_in_action)
		end
	end
end