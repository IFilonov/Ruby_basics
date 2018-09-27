class Train
  attr_reader :speed, :type

  def initialize(number, type)
    @number = number
    @type = type
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

  def set_route(route)
    @route = route
    @current_station = 0
    current_station.train_arrive(self)
  end

  def go_next_station
    if next_station
      current_station.send_train(self)
      @current_station += 1
      current_station.train_arrive(self)
    else
       puts "Train is at the final station"
    end
  end

  def go_previous_station
    if previous_station
      current_station.send_train(self)
      @current_station -= 1
      current_station.train_arrive(self)
    else
       puts "Train is at the starting station"
    end
  end

  def current_station
    @route.stations[@current_station]
  end

  def next_station
    @route.stations[@current_station + 1]
  end

  def previous_station
    @route.stations[@current_station - 1] if @current_station > 0
  end
end
