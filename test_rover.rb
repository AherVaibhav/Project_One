#!/usr/bin/ruby


require 'test/unit/ui/console/testrunner'
require "test/unit"
require "./mars_rover"
require "./nasa_controller"

class TestNasaController < NasaController
	public :initiate_grid, :initiate_rover, :move_rover
end

class NasaTests < Test::Unit::TestCase

	MarsPlateau.new(5, 5, 0, 0);

	# Mars Rover Test
	def test_mars_rover
		mr = MarsRover.new(0, 0, "N")
		assert_equal(0, mr.x)
		assert_equal(0, mr.y)
		assert_equal("N", mr.direction)
	end

	def test_mars_rover_execute_command_runtime_error
		mr = MarsRover.new(0, 0, "N")
		exception = assert_raise(RuntimeError) {mr.execute_commands("MMHL")}
		assert_equal("Command H is invalid.", exception.message) 
	end

	def test_mars_rover_stepback
		mr = MarsRover.new(5, 0, "N")
		mr.execute_commands("LLLLMM")
		assert_equal(5, mr.x)
	end

	def test_mars_change_direction_east
		mr = MarsRover.new(5, 0, "N")
		mr.execute_commands("R")
		assert_equal("E", mr.direction)
	end

	def test_mars_change_direction_west
		mr = MarsRover.new(5, 0, "N")
		mr.execute_commands("L")
		assert_equal("W", mr.direction)
	end

	def test_mars_change_direction_north
		mr = MarsRover.new(0, 0, "E")
		mr.execute_commands("L")
		assert_equal("N", mr.direction)
	end

	def test_mars_change_direction_south
		mr = MarsRover.new(0, 0, "E")
		mr.execute_commands("R")
		assert_equal("S", mr.direction)
	end

	def test_mars_rover_move_along_x_axis
		mr = MarsRover.new(3, 3, "E")
		mr.execute_commands("M")
		assert_equal(4, mr.x)
	end

	def test_mars_rover_move_along_y_axis
		mr = MarsRover.new(3, 4, "N")
		mr.execute_commands("M")
		assert_equal(5, mr.y)
	end

	def test_mars_rover_move
		mr = MarsRover.new(0, 0, "N")
		mr.move()
		assert_equal(1, mr.y)
	end

	# nasa controller test

	def test_validate_command
		nc = NasaController.new([" 3 3" , "2 2 E", "LLLLMD", "1 2 S", "RRRRM"])
		exception = assert_raise(RuntimeError) {nc.validate_rovers_commands()}
		assert_equal("unsupported command |LLLLMD| \n", exception.message) 	
	end

	def test_initiate_rover_outside_grid
		nc = TestNasaController.new([])
		exception = assert_raise(RuntimeError) {nc.initiate_rover("6 5 N")}
		assert_equal("starting coordinates of rover are not on grid", exception.message) 		
	end

	def test_initiate_rover_inside_grid
		nc = TestNasaController.new([])
		nc.initiate_rover("4 1 S")
		rover_in_action = MarsPlateau.rovers.pop
		assert_equal("x, y and direction 4,1, S \n", rover_in_action.to_string)
	end

	def test_move_rover
		nc = TestNasaController.new([])
		nc.initiate_rover("4 1 S")
		nc.move_rover("MRMMMM")
	 	rover_in_action = MarsPlateau.rovers.pop
		assert_equal("x, y and direction 0,0, W \n", rover_in_action.to_string)
	end 


end



Test::Unit::UI::Console::TestRunner.run(NasaTests)