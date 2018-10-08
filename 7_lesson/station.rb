require_relative "instance_counter"
require_relative "validation"

class Station
  include InstanceCounter
  include Validation
  attr_reader :name, :trains
  alias_method :info, :name
  @@stations = []

  def self.all
    @@stations
  end

  def initialize(station_name)
    @name = station_name
    validate!
    @trains = []
    @@stations << self
    register_instance
  end

  def train_arrive(train)
    @trains << train
  end

  def send_train(train)
    @trains.delete(train)
  end

  private
#вывод поездов по типу не используется
  def get_trains_by_type(train_class)
    @trains.select { |train| train.class == train_class }
  end

  def validate!
    if @name.nil? || @name.length > 20 || @name.length < 2
      raise "Error: station name must be from 2 to 20 symbols!"
    end
  end
end
