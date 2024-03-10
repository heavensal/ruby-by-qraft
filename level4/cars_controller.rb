# je crée des cars via le json
require 'json'
require_relative 'car'

class CarsController
  attr_reader :json

  def initialize(args = {})
    @json = args[:json]
  end

  def create
    data = JSON.parse(File.read(@json))
    data['cars'].each do |car|
      Car.new(id: car['id'], price_per_day: car['price_per_day'], price_per_km: car['price_per_km'])
    end
  end
end
