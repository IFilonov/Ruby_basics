require_relative "train"
require_relative "passenger_wagon"

class PassengerTrain < Train

  PASSENGER_TYPE = :passenger

  def initialize(number)
    super(number, PASSENGER_TYPE)
  end

  def can_add_wagon?(wagon)
    wagon.instance_of?(PassengerWagon)
  end
end
