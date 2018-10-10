require_relative "wagon"

class PassengerWagon < Wagon
  attr_reader :free_seats
  PASSENGER_TYPE = :passenger


  def initialize(seats, number)
    @seats = seats
    @free_seats = seats
    @type = PASSENGER_TYPE
    validate!
    super(number)
  end

  def is_cargo?
    false
  end

  def occupy_seat
    @free_seats = OCCUPY.call(@free_seats)
  end

  def occupied_seats
    GET_OCCUPIED.call(@seats, @free_seats)
  end

   def validate!
    raise ERR_MGS[:WRONG_NUMBER] unless @seats.to_s =~ VALID_REGEXP
  end
end
