require_relative 'instance_counter'
require_relative 'validation'

class Station
  include InstanceCounter
  include Validation
  attr_reader :name, :trains
  alias info name
  @stations = []

  ERR_MGS = {
    WRONG_NAME: 'Error: station name must be from 2 to 20 symbols!'
  }.freeze

  def self.all
    @stations
  end

  def initialize(station_name)
    @name = station_name
    validate!
    @trains = []
    self.class.add_station(self)
    register_instance
  end

  def self.add_station(station)
    @stations.push(station)
  end

  def train_arrive(train)
    @trains << train
  end

  def send_train(train)
    @trains.delete(train)
  end

  def each_train
    @trains.each { |train| yield(train) }
  end

  private

  # dont used or used in public methods
  def get_trains_by_type(train_class)
    @trains.select { |train| train.class == train_class }
  end

  def validate!
    regexp = /^\w{2,}.{,18}$/
    raise ERR_MGS[:WRONG_NAME] unless @name =~ regexp
  end
end
