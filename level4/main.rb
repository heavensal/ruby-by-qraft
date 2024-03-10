require 'json'
require 'date'

require_relative 'cars_controller'
require_relative 'rentals_controller'
require_relative 'rental'
require_relative 'car'
require_relative 'action'

cars_controller = CarsController.new(json: 'level4/data/input.json')
cars_controller.create

rentals_controller = RentalsController.new(json: 'level4/data/input.json')
rentals_controller.create

output = Rental.all.map do |rental|
  { id: rental.id,
    actions: rental.actions.map do |action|
      { who: action.who,
        type: action.type,
        amount: action.amount }
    end
  }
end

File.open('level4/data/output.json', 'w') do |file|
  file.write(JSON.pretty_generate(rentals: output))
end
