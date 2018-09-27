class Route
  attr_reader :stations

  def initialize(begin_station, end_station)
    @stations = [begin_station, end_station]
  end

  def add_station(station)
    @stations.insert(1, station)
  end

  def del_station(station)
    @stations.delete(station) unless [@stations[0], @stations[-1]].include?(station)
  end

  def put_stations_name
    @stations.each { |station| puts station.name }
  end
end
