require_relative 'wagon'

class CargoWagon < Wagon
  CARGO_TYPE = :cargo

  def initialize(place, number)
    @type = CARGO_TYPE
    super(place, number)
  end

  def cargo?
    true
  end

  def self.place_str
    'volume'
  end
end
