require_relative "instance_counter"
require_relative "validation"

class Route
  include InstanceCounter
  include Validation
  attr_reader :stations, :number
  alias_method :info, :number

  ERR_MGS = {
    SAME_STATIONS: "Error: stations cannot be same in route!",
    WRONG_CLASS: "Error: first and end station must be class of Station!"
  }

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
    @stations.delete(station) unless [@stations[0], @stations[-1]].include?(station)
  end

  private
  #не используются снаружи класса Route
  def put_stations_name
    @stations.each { |station| station.info }
  end

  def validate!
    raise ERR_MGS[:SAME_STATIONS] if @stations.first == @stations.last
    raise ERR_MGS[:WRONG_CLASS] unless @stations.first.is_a?(Station) && @stations.last.is_a?(Station)
  end
end
