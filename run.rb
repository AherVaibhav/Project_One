#!/usr/bin/ruby
require './nasa_controller'

begin
	main = NasaController.new([ "5 5", "1 2 N", "LMLMLMLMM", "3 3 E", "MMRMMRMRRM"])
	main.validate_rovers_commands
    main.start_rovers_commands
    MarsPlateau.rovers.each_with_index {|rover, index| print "Rover #{index+1}: #{rover.to_string()}"}

rescue RuntimeError => e
	print "#{e.class} => #{e.inspect}"
end