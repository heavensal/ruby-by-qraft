require 'json'
require 'date'

require_relative 'cars_controller'
require_relative 'rentals_controller'
require_relative 'options_controller'

cars_controller = CarsController.new(json: 'level5/data/input.json')
cars_controller.create

rentals_controller = RentalsController.new(json: 'level5/data/input.json')
rentals_controller.create

options_controller = OptionsController.new(json: 'level5/data/input.json')
options_controller.create


Rental.all.each do |rental|
  rental.calc_actions
end

output = Rental.all.map do |rental|
  { id: rental.id,
    options: rental.options.map { |option| option.type },
    actions: rental.actions.map do |action|
      { who: action.who,
        type: action.type,
        amount: action.amount }
    end
  }
end

File.open('level5/data/output.json', 'w') do |file|
  file.write(JSON.pretty_generate(rentals: output))
end
