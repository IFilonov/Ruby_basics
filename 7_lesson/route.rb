require_relative "instance_counter"

class Route
  include InstanceCounter
  attr_reader :stations, :number
  alias_method :info, :number

  def initialize(begin_station, end_station)
    @stations = [begin_station, end_station]
    raise "Stations cannot be same in route" unless valid?
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

  def valid?
    return @stations[0] != @stations[1]
  end
end
