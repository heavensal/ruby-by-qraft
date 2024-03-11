# je crée des options via le json et les rentals existants
require 'json'
require 'date'

require_relative 'rental'
require_relative 'option'

class OptionsController
  attr_reader :json

  def initialize(args = {})
    @json = args[:json]
  end

  def create
    data = JSON.parse(File.read(@json))
    data['options'].each do |option|
      Option.new(id: option['id'],
                rental: Rental.find(option['rental_id']),
                type: option['type'])
    end
  end
end
