require_relative 'wagon'

class PassengerWagon < Wagon
  PASSENGER_TYPE = :passenger

  def initialize(place, number)
    @type = PASSENGER_TYPE
    super(place, number)
  end

  def cargo?
    false
  end

  def occupy_place(_place)
    super(1)
  end

  def self.place_str
    'seats'
  end
end
