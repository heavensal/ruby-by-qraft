class Option
  attr_reader :id, :rental, :type
  def initialize(args = {})
    @id = args[:id]
    @rental = args[:rental]
    @type = args[:type]
  end

  def self.all
    ObjectSpace.each_object(self).to_a.reverse
  end
end
