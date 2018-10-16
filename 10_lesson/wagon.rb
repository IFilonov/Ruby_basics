require_relative 'manufacturer'

class Wagon
  include Manufacturer

  attr_reader :number, :type, :place, :free_place

  def initialize(place, number)
    @number = number
    @place = place
    @free_place = place
  end

  def info
    self
  end

  def occupied
    @place - @free_place
  end

  def occupy_place(occupy_val)
    @free_place -= occupy_val if @free_place >= occupy_val
  end
end
