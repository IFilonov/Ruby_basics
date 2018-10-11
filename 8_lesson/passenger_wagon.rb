require_relative "wagon"

class PassengerWagon < Wagon

  PASSENGER_TYPE = :passenger

  def initialize(place, number)
    @type = PASSENGER_TYPE
    super(place, number)
  end

  def is_cargo?
    false
  end

  def occupy_place
    super(1)
  end
end
