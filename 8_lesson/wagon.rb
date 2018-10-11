require_relative "manufacturer"

class Wagon
  include Manufacturer

  attr_reader :number, :type
  VALID_REGEXP = /^[1-9]\d*$/

  ERR_MGS = {
    WRONG_NUMBER: "Error: value must be any number greater then zero!",
    NOT_ENOUGH_VALUE: "Error: no free place to occupy!"
  }

  def initialize(number)
    @number = number
  end

  def info
    self
  end

  protected

  def get_occupied
    place - free_place
  end

  def occupy(occupy_val)
    raise ERR_MGS[:NOT_ENOUGH_VALUE] if free_place < occupy_val
    raise ERR_MGS[:WRONG_NUMBER] unless occupy_val.to_s =~ VALID_REGEXP
    free_place - occupy_val
  end
end
