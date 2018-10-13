require_relative 'train'

class CargoTrain < Train
  CARGO_TYPE = :cargo

  def initialize(number)
    super(number, CARGO_TYPE)
  end

  def add_wagon(wagon)
    super(wagon) if can_add_wagon?(wagon)
  end

  private

  def can_add_wagon?(wagon)
    wagon.cargo?
  end
end
