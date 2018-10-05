require_relative "manufacturer"

class Wagon
  include Manufacturer

  def info
    self
  end
end
