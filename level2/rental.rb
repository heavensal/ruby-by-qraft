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
    r = (self.end_date - self.start_date).to_f + 1
    d = self.car.price_per_day

    if r > 10
      price = d * (7.9 + (r-10) * 0.5)
    elsif r > 4
      price = d * (3.7 + (r-4) * 0.7)
    elsif r > 1
      price = d * (1 + (r-1) * 0.9)
    else
      price = d
    end
    return (price += self.distance * self.car.price_per_km).to_i
  end

  def self.find(id)
    Rental.all.find { |rental| rental.id == id }
  end

  def self.all
    ObjectSpace.each_object(self).to_a.reverse
  end
end
