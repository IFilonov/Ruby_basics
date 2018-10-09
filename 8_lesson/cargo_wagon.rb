require_relative "wagon"

class CargoWagon < Wagon
  attr_reader :free_volume

  def initialize(volume)
    @volume = volume
    @free_volume = volume
    validate!
  end

  def is_cargo?
    true
  end

  def occupy_volume(volume)
    @free_volume -= volume if @free_volume > 0
  end

  def occupied_volume
    @volume - @free_volume
  end

  private

  def validate!
    raise ERR_MGS[:WRONG_VOLUME] unless @volume.to_s =~ VALID_REGEXP
  end
end
