# model action définissant qui perçoit quoi
require_relative 'rental'

class Action
  attr_reader :rental, :who, :type, :amount
  def initialize(args = {})
    @rental = args[:rental]
    @who = args[:who]
    @type = args[:type]
    @amount = args[:amount]
  end

  def self.all
    ObjectSpace.each_object(self).to_a.reverse
  end
end
