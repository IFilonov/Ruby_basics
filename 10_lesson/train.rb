require_relative 'manufacturer'
require_relative 'instance_counter'
require_relative 'validation'

class Train
  include Manufacturer
  include InstanceCounter
  include Validation

  NUMBER_REGEXP = /^[a-zA-Z0-9]{3}-?[a-zA-Z0-9]{2}$/
  attr_reader :speed, :number, :wagons, :type
  validate :type, :presence
  validate :number, :presence
  validate :number, :format, NUMBER_REGEXP

  alias info number
  @trains = {}

  ERR_MESSAGES = {
    ERR_TRAIN_NUM: 'Error: train number not valid!',
    ERR_TRAIN_TYPE: 'Error: train type cannot be null!'
  }.freeze

  def initialize(number, type)
    @number = number
    @speed = 0
    @type = type
    @wagons = []
    validate!
    self.class.add_train(self)
    register_instance
  end

  def self.add_train(train)
    @trains[train.number] = train
  end

  def add_wagon(wagon)
    return unless speed.zero?

    @wagons << wagon
  end

  def unhook_wagon(wagon)
    @wagons.delete(wagon) if !@wagons.empty? && @speed.zero?
  end

  def route(route)
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
      puts 'Train is at the final station'
    end
  end

  def go_previous_station
    if previous_station
      current_station.send_train(self)
      @current_station -= 1
      current_station.train_arrive(self)
    else
      puts 'Train is at the starting station'
    end
  end

  def self.find(number)
    @trains[number]
  end

  def each_wagon
    @wagons.each { |wagon| yield(wagon) }
  end

  private

  # methods below dont used out of class train

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
