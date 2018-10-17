require_relative 'instance_counter'
require_relative 'validation'
require_relative 'station'
require_relative 'accessors'

class Route
  include InstanceCounter
  include Validation
  extend Accessors
  attr_reader :stations
  strong_attr_accessor :number, Route
  strong_attr_accessor :begin_station, Station
  strong_attr_accessor :end_station, Station
  alias info number
  validate :begin_station, :type, Station
  validate :end_station, :type, Station

  ERR_MGS = {
    SAME_STATIONS: 'Error: stations cannot be same in route!',
    WRONG_CLASS: 'Error: first and end station must be class of Station!'
  }.freeze

  def initialize(begin_station, end_station)
    @begin_station = begin_station
    @end_station = end_station
    validate!
    @stations = [begin_station, end_station]
    @number = self
    register_instance
  end

  def add_station(station)
    @stations.insert(1, station)
  end

  def del_station(station)
    base_station = [@stations[0], @stations[-1]].include?(station)
    @stations.delete(station) unless base_station
  end

  private

  # dont used out of class Route
  def put_stations_name
    @stations.each(&:info)
  end
end
