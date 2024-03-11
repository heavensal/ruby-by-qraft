# Model Rental
require_relative 'car'
require_relative 'action'

class Rental
  attr_reader :id, :car, :start_date, :end_date, :distance
  attr_accessor :price, :commission

  def initialize(args = {})
    @id = args[:id]
    @car = args[:car]
    @start_date = args[:start_date]
    @end_date = args[:end_date]
    @distance = args[:distance]
    @price = price
    @commission = { insurance_fee: insurance_fee,
                    assistance_fee: assistance_fee,
                    drivy_fee: drivy_fee}
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
    price += services_amount
    return (price += self.distance * self.car.price_per_km).to_i
  end

  def owner_fee
    return ((self.price - services_amount) * 0.7 + gps + baby_seat).to_i
  end

  def insurance_fee
    return ((self.price - services_amount) * 0.15).to_i
  end

  def assistance_fee
    return 100 * ((self.end_date - self.start_date).to_i + 1)
  end

  def drivy_fee
    return ((self.price - services_amount) * 0.3 - self.insurance_fee - self.assistance_fee + additional_insurance).to_i
  end

  def calc_actions
    Action.new(rental: self, who: 'driver', type: 'debit', amount: price)
    Action.new(rental: self, who: 'owner', type: 'credit', amount: owner_fee)
    Action.new(rental: self, who: 'insurance', type: 'credit', amount: insurance_fee)
    Action.new(rental: self, who: 'assistance', type: 'credit', amount: assistance_fee)
    Action.new(rental: self, who: 'drivy', type: 'credit', amount: drivy_fee)
  end

  def actions
    Action.all.select { |action| action.rental == self }
  end

  def options
    return Option.all.select { |option| option.rental == self }
  end

  def gps
    if options.any? { |option| option.type == 'gps' }
      return 500 * ((self.end_date - self.start_date).to_i + 1)
    else
      return 0
    end
  end

  def baby_seat
    if options.any? { |option| option.type == 'baby_seat' }
      return 200 * ((self.end_date - self.start_date).to_i + 1)
    else
      return 0
    end
  end

  def additional_insurance
    if options.any? { |option| option.type == 'additional_insurance' }
      return 1000 * ((self.end_date - self.start_date).to_i + 1)
    else
      return 0
    end
  end

  def services_amount
    return gps + baby_seat + additional_insurance
  end

  def self.find(id)
    Rental.all.find { |rental| rental.id == id }
  end

  def self.all
    ObjectSpace.each_object(self).to_a.reverse
  end
end
