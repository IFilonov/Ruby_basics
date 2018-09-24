class Station

  attr_reader :name, :trains

  def initialize (station_name)
    @name = station_name
    @trains = []
  end

  def train_arrive (train)
    @trains << train
  end

  def get_trains_by_type (type)
    return @trains.select { |train| train.type == type }
  end

  def send_train (train)
    @trains.delete(train)
  end

end

class Route

  attr_reader :stations

  def initialize (begin_station, end_station)
    @stations = [begin_station, end_station]
  end

  def add_station(station)
    @stations.insert(1, station)
  end

  def del_station(station)
    @stations.delete_at(1, station) if @stations.length > 2
  end

  def put_stations_name
    @stations.each { |station| puts station.name }
  end

end

class Train

  attr_reader :speed, :wagons, :type

  def initialize (number, type, wagon_count)
    @number = number
    @type = type
    @wagons = wagon_count
    @speed = 0
  end

  def increase_speed(value)
    @speed += value
  end

  def decrease_speed(value)
    value < @speed ? @speed -= value : @speed = 0
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
    if @route.stations.length - 1 > @current_station
      @route.stations[@current_station].send_train(self)
      @current_station += 1
      @route.stations[@current_station].train_arrive(self)
    else
      puts "Train is at the final station"
    end
  end

  def go_previous_station
    if @current_station != 0
      @route.stations[@current_station].send_train(self)
      @current_station -= 1
      @route.stations[@current_station].train_arrive(self)
    else
      puts "Train is at the starting station"
    end
  end

  def get_current_station
    return @route.stations.values_at(@current_station)
  end

  def get_next_station
    return @route.stations.values_at([@current_station + 1, @route.stations.length - 1].min)
  end

  def get_previous_station
    return @route.stations.values_at([@current_station - 1, 0].max)
  end

end
