require_relative "manufacturer"

class Wagon
  include Manufacturer
  VALID_REGEXP = /^[1-9]\d*$/

  ERR_MGS = {
    WRONG_VOLUME: "Error: volume must be any number greater then zero!"
  }

  def info
    self
  end
end
