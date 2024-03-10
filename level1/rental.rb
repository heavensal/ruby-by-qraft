# Model Rental
require_relative 'car'

class Rental
  attr_reader :id, :car, :start_date, :end_date, :distance
  attr_accessor :price

  def initialize(args = {})
    @id = args[:id]
    @car = args[:car]
    @start_date = args[:start_date]
    @end_date = args[:end_date]
    @distance = args[:distance]
    @price = price
  end

  def price
    ((self.end_date-self.start_date).to_i + 1) * self.car.price_per_day + self.distance * self.car.price_per_km
  end

  def self.find(id)
    Rental.all.find { |rental| rental.id == id }
  end

  def self.all
    ObjectSpace.each_object(self).to_a.reverse
  end
end
