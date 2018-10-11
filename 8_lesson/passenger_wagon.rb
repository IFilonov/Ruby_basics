require_relative "wagon"

class PassengerWagon < Wagon
  attr_reader :free_seats, :seats
  alias_method :place, :seats
  alias_method :free_place, :free_seats
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
    @free_seats = occupy(1)
  end

  def occupied_seats
    get_occupied
  end

  def validate!
    raise ERR_MGS[:WRONG_NUMBER] unless @seats.to_s =~ VALID_REGEXP
  end
end
