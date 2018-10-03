require_relative "wagon"

class PassengerWagon < Wagon

  def is_cargo?
    false
  end
end
