# je crée des rentals via le json et les cars existant
require 'json'
require 'date'

require_relative 'car'
require_relative 'rental'

class RentalsController
  attr_reader :json

  def initialize(args = {})
    @json = args[:json]
  end

  def create
    data = JSON.parse(File.read(@json))
    data['rentals'].each do |rental|
      r = Rental.new(id: rental['id'],
                    car: Car.find(rental['car_id']),
                    start_date: Date.parse(rental['start_date']),
                    end_date: Date.parse(rental['end_date']),
                    distance: rental['distance'])
    end
  end
end
