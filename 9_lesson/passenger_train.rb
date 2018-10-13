require_relative 'train'

class PassengerTrain < Train
  PASSENGER_TYPE = :passenger

  def initialize(number)
    super(number, PASSENGER_TYPE)
  end

  def add_wagon(wagon)
    super(wagon) if can_add_wagon?(wagon)
  end

  private

  def can_add_wagon?(wagon)
    !wagon.cargo?
  end
end
