require_relative "wagon"

class CargoWagon < Wagon
  attr_reader :free_volume
  CARGO_TYPE = :cargo

  def initialize(volume, number)
    @volume = volume
    @free_volume = volume
    @type = CARGO_TYPE
    validate!
    super(number)
  end

  def is_cargo?
    true
  end

  def occupy_volume(volume)
    @free_volume = OCCUPY.call(@free_volume, volume)
  end

  def occupied_volume
    GET_OCCUPIED.call(@volume, @free_volume)
  end

  private

  def validate!
    raise ERR_MGS[:WRONG_VOLUME] unless @volume.to_s =~ VALID_REGEXP
  end
end
