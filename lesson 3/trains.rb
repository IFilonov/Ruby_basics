:PASSENGER_TYPE
:CARGO_TYPE

class Station

  attr_reader :station_name, :trains

def initialize (station_name)
  @station_name = station_name
  @trains = []
end

def train_arrive (train)
  @trains << train
end

def get_trains_by_types
  num_passenger_trains = 0
  num_cargo_trains = 0
  @trains.each { |train| num_passenger_trains += 1 if train.type == :PASSENGER_TYPE }
  num_cargo_trains = @trains.length - num_passenger_trains
  return "Number of passenger trains: #{num_passenger_trains}, number of cargo trains: #{num_cargo_trains}"
end

def send_train (train)
  @trains.delete(train)
end


end

class Route

  attr_reader :stations

def initialize (begin_station, end_station)
  @stations = []
  @stations.push(begin_station).push(end_station)
end

def add_station(station)
  @stations.insert(1, station)
end

def del_station(station)
  @stations.delete(station) if @stations.length > 2
end

def put_stations_name
  @stations.each { |station| puts station.station_name }
end

end

class Train

  attr_reader :speed, :wagons, :type

def initialize (type, wagon_count)
  @number = ("0".."9").to_a.shuffle.join
  @type = type
  @wagons = wagon_count
  @speed = 0
end

def speed_up
  @speed += 1
end

def stop
  @speed = 0
end

def add_wagon
  @wagons += 1 if @speed == 0
end

def unhook_wagon
  @wagons -= 1 if @speed == 0 && @wagons > 0
end

def set_route (route)
  @route = route
  @current_station = 0
  @route.stations[@current_station].train_arrive(self)
end

def go_next_station
  @route.stations[@current_station].send_train(self)
  @current_station += 1
  @route.stations[@current_station].train_arrive(self)
end

def go_previous_station
  @route.stations[@current_station].send_train(self)
  @current_station -= 1
  @route.stations[@current_station].train_arrive(self)
end

def get_current_stations
  @route.stations.values_at(@current_station - 1, @current_station, @current_station + 1)
end

end
