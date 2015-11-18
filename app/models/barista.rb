class Barista < ActiveRecord::Base
	has_many :coffees

	validates :name, length: {minimum: 5}
end
