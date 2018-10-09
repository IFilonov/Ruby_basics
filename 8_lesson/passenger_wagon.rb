require_relative "wagon"

class PassengerWagon < Wagon
  attr_reader :free_seats

  def initialize(number_seats)
    @number_seats = number_seats
    @free_seats = number_seats
    validate!
  end

  def is_cargo?
    false
  end

  def occupy_seat
    @block_occupy = lambda { |x| x -= 1 if x }
    @block_occupy.call(@free_seats)
  end

  def occupied_seats
    @number_seats - @free_seats
  end

   def validate!
    raise ERR_MGS[:WRONG_VOLUME] unless @number_seats.to_s =~ VALID_REGEXP
  end
end
