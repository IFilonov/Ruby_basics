require_relative "wagon"

class CargoWagon < Wagon
  attr_reader :free_volume, :volume
  alias_method :place, :volume
  alias_method :free_place, :free_volume
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
    @free_volume = occupy(volume)
  end

  def occupied_volume
    get_occupied
  end

  private

  def validate!
    raise ERR_MGS[:WRONG_VOLUME] unless @volume.to_s =~ VALID_REGEXP
  end
end
