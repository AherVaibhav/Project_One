class MarsPlateau
	
	@@rovers =[]

	def initialize (max_x, max_y, min_x, min_y)
		@@max_x = max_x
		@@max_y = max_y
		@@min_x = min_x
		@@min_y = min_y
	end

	def self.max_x
		@@max_x
	end

	def self.max_y
		@@max_y
	end

	def self.min_x
		@@min_x
	end

	def self.min_y
		@@min_y
	end

	def self.rovers
		@@rovers
	end

end