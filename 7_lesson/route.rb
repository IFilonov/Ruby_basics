require_relative "instance_counter"
require_relative "validation"

class Route
  include InstanceCounter
  include Validation
  attr_reader :stations, :number
  alias_method :info, :number

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
    if @stations[0] == @stations[1]
      raise "Error: stations cannot be same in route!"
    elsif !@stations[0].instance_of?(Station) || !@stations[0].instance_of?(Station)
      raise "Error: first and end station must be class of Station!"
    end
  end
end
