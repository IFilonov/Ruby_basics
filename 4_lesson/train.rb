class Train
  attr_reader :speed, :number, :wagons
  alias_method :info, :number

  def initialize(number, type)
    @number = number
    @speed = 0
    @wagons = []
    @type = type
  end

  def add_wagon(wagon)
    return unless speed == 0
    @wagons << wagon
  end

  def unhook_wagon(wagon)
    @wagons.delete(wagon) if @wagons.length > 0 && @speed == 0
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

  private
  #ниже методы не используются снаружи класса train

  def wagons_number
    @wagons.length
  end

  def increase_speed(value)
    @speed += value
  end

  def decrease_speed(value)
    value < @speed ? @speed -= value : @speed = 0
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
