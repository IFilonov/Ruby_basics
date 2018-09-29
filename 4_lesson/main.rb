require_relative "cargo_train"
require_relative "passenger_train"
require_relative "route"
require_relative "station"
require_relative "passenger_wagon"
require_relative "cargo_wagon"

class Main

  APP_NAME = "RailWay Manager"
  VERSION = 1.0

  def initialize

    puts "#{APP_NAME} #{VERSION}"

    @main_menu = [
      "Manage stations",
      "Manage trains",
      "Manage routes"
    ]

    @station_menu = [
      "Create station",
      "Show stations and trains"
    ]

     @train_menu = [
      "Create cargo train",
      "Create passenger train",
      "Add wagon to train",
      "Unhook wagon from train",
      "Move train forward",
      "Move train backward"
    ]

    @route_menu = [
      "Create route",
      "Add station to route",
      "Delete station from route",
      "Set route to train"
    ]

    @stations = []
    @routes = []
    @trains = []
  end

  def main
    loop do
      show_menu(@main_menu)
      menu_item = gets.chomp.to_s
      break if menu_item == "stop"
      call_method(menu_item, @main_menu)
    end
  end

private
#методы ниже не вызываются снаружи класса либо подклассами

  def manage_stations
    loop do
      show_menu(@station_menu)
      menu_item = gets.chomp.to_s
      break if menu_item == "stop"
      call_method(menu_item, @station_menu)
    end
  end

  def manage_trains
    loop do
      show_menu(@train_menu)
      menu_item = gets.chomp.to_s
      break if menu_item == "stop"
      call_method(menu_item, @train_menu)
    end
  end

  def manage_routes
    loop do
      show_menu(@route_menu)
      menu_item = gets.chomp.to_s
      break if menu_item == "stop"
      call_method(menu_item, @route_menu)
    end
  end

  def create_station
    station_name = get_user_input("Enter new station name")
    @stations << Station.new(station_name)
  end

  def show_stations_and_trains
    @stations.each { |station|
      puts "Station: #{station.name}"
      puts "Trains on station: #{station.get_trains_numbers}"
    }
  end

  def create_cargo_train
    train_number = get_user_input("Enter new train number")
    @trains << CargoTrain.new(train_number)
  end

  def create_passenger_train
    train_number = get_user_input("Enter new passenger train number")
    @trains << PassengerTrain.new(train_number)
  end

  def add_wagon_to_train
    train_number = get_user_input("Enter train number")
    train = get_train(train_number)
    wagon = train.instance_of?(CargoTrain) ? CargoWagon.new : PassengerWagon.new
    train.add_wagon(wagon) if train
  end

  def unhook_wagon_from_train
    train_number = get_user_input("Enter train number")
    train = get_train(train_number)
    train.unhook_wagon if train
  end

  def create_route
    first_station = get_user_input("Enter first station name")
    end_station = get_user_input("Enter end station name")
    @routes << Route.new(get_station(first_station), get_station(end_station))
    puts "Route number #{@routes.length} created"
  end

  def add_station_to_route
    station_name = get_user_input("Enter station name to add")
    route_number = get_user_input("Enter number of route")
    @routes[route_number.to_i-1].add_station(get_station(station_name))
  end

  def delete_station_from_route
    station_name = get_user_input("Enter station name to del")
    route_number = get_user_input("Enter number of route")
    @routes[route_number.to_i-1].del_station(get_station(station_name))
  end

  def set_route_to_train
    train_number = get_user_input("Enter train number")
    route_number = get_user_input("Enter number of route")
    get_train(train_number).set_route(@routes[route_number.to_i-1])
  end

  def move_train_forward
    train_number = get_user_input("Enter train number")
    train = get_train(train_number)
    train.go_next_station  if train
  end

  def move_train_backward
    train_number = get_user_input("Enter train number")
    train = get_train(train_number)
    train.go_previous_station if train
  end

 def show_menu(menu)
    puts "Enter number to select menu item or type stop to exit:"
    menu.each_with_index { |value,index| puts "#{index} - #{value}" }
  end

  def call_method(item, menu)
    send(menu[item.to_i].downcase.gsub(" ", "_")) if menu[item.to_i] && item.to_i.to_s == item
  end

  def get_user_input(text)
    puts text
    gets.chomp.to_s
  end

  def get_station(name)
    @stations.find { |station| station.name == name }
  end

  def get_train(number)
    @trains.find { |train| train.number == number }
  end
end

m = Main.new
m.main
