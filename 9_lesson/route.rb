require_relative 'instance_counter'
require_relative 'validation'

class Route
  include InstanceCounter
  include Validation
  attr_reader :stations, :number
  alias info number

  ERR_MGS = {
    SAME_STATIONS: 'Error: stations cannot be same in route!',
    WRONG_CLASS: 'Error: first and end station must be class of Station!'
  }.freeze

  def initialize(begin_station, end_station)
    @stations = [begin_station, end_station]
    validate!
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

  def validate!
    raise ERR_MGS[:SAME_STATIONS] if @stations.first == @stations.last

    err_class = @stations.first.is_a?(Station) && @stations.last.is_a?(Station)
    raise ERR_MGS[:WRONG_CLASS] unless err_class
  end
end
