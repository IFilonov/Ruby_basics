require_relative "wagon"

class CargoWagon < Wagon

  def is_cargo?
    true
  end
end
