# Model Car

class Car
  attr_reader :id, :price_per_day, :price_per_km

  def initialize(args = {})
    @id = args[:id]
    @price_per_day = args[:price_per_day]
    @price_per_km = args[:price_per_km]
  end

  def self.find(id)
    Car.all.find { |car| car.id == id }
  end

  def self.all
    ObjectSpace.each_object(self).to_a.reverse
  end
end
