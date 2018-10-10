require_relative "manufacturer"

class Wagon
  include Manufacturer

  attr_reader :number, :type
  VALID_REGEXP = /^[1-9]\d*$/

  ERR_MGS = {
    WRONG_NUMBER: "Error: value must be any number greater then zero!",
    NOT_ENOUGH_VALUE: "Error: no free place to occupy!"
  }

  OCCUPY = Proc.new do |free_val, occupy_val|
    occupy_val = 1 unless occupy_val
    raise ERR_MGS[:NOT_ENOUGH_VALUE] if free_val < occupy_val
    raise ERR_MGS[:WRONG_NUMBER] unless occupy_val.to_s =~ VALID_REGEXP
    free_val -= occupy_val
  end

  GET_OCCUPIED = lambda { |num_val, free_val| num_val - free_val }

  def initialize(number)
    @number = number
  end

  def info
    self
  end
end
