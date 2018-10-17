require_relative 'instance_counter'
require_relative 'validation'
require_relative 'accessors'

class Station
  include InstanceCounter
  include Validation
  extend Accessors
  STATION_REGEXP = /^\w{2,}.{,18}$/
  attr_reader :trains
  strong_attr_accessor :name, String
  alias info name
  validate :name, :presence
  validate :name, :format, STATION_REGEXP

  @stations = []

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
end
