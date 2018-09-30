class Route
  attr_reader :stations, :number

  def initialize(begin_station, end_station)
    @stations = [begin_station, end_station]
    @number = self
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
    @stations.each { |station| puts station.number }
  end
end
