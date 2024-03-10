require 'json'
require 'date'

require_relative 'cars_controller'
require_relative 'rentals_controller'

cars_controller = CarsController.new(json: 'level3/data/input.json')
cars_controller.create

rentals_controller = RentalsController.new(json: 'level3/data/input.json')
rentals_controller.create

output = Rental.all.map do |rental|
  { id: rental.id,
    price: rental.price,
    commission: { insurance_fee: rental.insurance_fee,
                  assistance_fee: rental.assistance_fee,
                  drivy_fee: rental.drivy_fee } }
end
File.open('level3/data/output.json', 'w') do |file|
  file.write(JSON.pretty_generate(rentals: output))
end
