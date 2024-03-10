require 'json'
require 'date'

require_relative 'cars_controller'
require_relative 'rentals_controller'

cars_controller = CarsController.new(json: 'level2/data/input.json')
cars_controller.create

rentals_controller = RentalsController.new(json: 'level2/data/input.json')
rentals_controller.create

output = Rental.all.map { |rental| { id: rental.id, price: rental.price } }
File.open('level2/data/output.json', 'w') do |file|
  file.write(JSON.pretty_generate(rentals: output))
end
