require_relative "cargo_train"
require_relative "passenger_train"
require_relative "route"
require_relative "station"
require_relative "passenger_wagon"
require_relative "cargo_wagon"

class Main

  APP_NAME = "RailWay Manager"
  VERSION = 1.2

  MAIN_MENU = [
    { label: "Manage stations", handler: :manage_stations },
    { label: "Manage trains", handler: :manage_trains },
    { label: "Manage routes", handler: :manage_routes }
  ]

  STATION_MENU = [
    { label: "Create station", handler: :create_station },
    { label: "Show stations and trains", handler: :show_stations_and_trains }
  ]

   TRAIN_MENU = [
    { label: "Create train", handler: :create_train },
    { label: "Add wagon to train", handler: :add_wagon_to_train },
    { label: "Unhook wagon from train", handler: :unhook_wagon_from_train },
    { label: "Move train forward", handler: :move_train_forward },
    { label: "Move train backward", handler: :move_train_backward }
  ]

  ROUTE_MENU = [
    { label: "Create route", handler: :create_route },
    { label: "Add station to route", handler: :add_station_to_route },
    { label: "Delete station from route", handler: :delete_station_from_route },
    { label: "Set route to train", handler: :set_route_to_train }
  ]

  QUIT_MENU = "q"

  TRAIN_CLASSES = [
     { class_name: CargoTrain, menu_info: "Cargo", train_type: :CARGO_TYPE},
     { class_name: PassengerTrain, menu_info: "Passenger", train_type: :PASSENGER_TYPE}
  ]

  def initialize
    puts "#{APP_NAME} #{VERSION}"
    @stations = []
    @routes = []
    @trains = []
  end

  def main
    loop do
      show_menu(MAIN_MENU)
      menu_item = gets.chomp.to_s
      break if menu_item == QUIT_MENU
      call_item_handler(menu_item, MAIN_MENU)
    end
  end

private
#методы ниже не вызываются снаружи класса либо подклассами

  def manage_stations
    loop do
      show_menu(STATION_MENU)
      menu_item = gets.chomp.to_s
      break if menu_item == QUIT_MENU
      call_item_handler(menu_item, STATION_MENU)
    end
  end

  def manage_trains
    loop do
      show_menu(TRAIN_MENU)
      menu_item = gets.chomp.to_s
      break if menu_item == QUIT_MENU
      call_item_handler(menu_item, TRAIN_MENU)
    end
  end

  def manage_routes
    loop do
      show_menu(ROUTE_MENU)
      menu_item = gets.chomp.to_s
      break if menu_item == QUIT_MENU
      call_item_handler(menu_item, ROUTE_MENU)
    end
  end

  def create_station
    station_name = get_user_input("Enter new station name:")
    @stations << Station.new(station_name)
  end

  def show_stations_and_trains
    @stations.each do |station|
      puts "Station: #{station.info}"
      puts "Trains on station:" if station.trains.size > 0
      station.trains.each { |train| puts "#{train.info}" }
    end
  end

  def create_train
    type_idx = get_selected_index("Select type of train to create", TRAIN_CLASSES)
    train_number = get_user_input("Enter new train number:")
    @trains << TRAIN_CLASSES[type_idx][:class_name].new(train_number,TRAIN_CLASSES[type_idx][:train_type])
  end

  def add_wagon_to_train
    train_index = get_selected_index("Select number of train to add wagon", @trains)
    wagon_amount = get_user_input("Enter amount of wagons to add:")
    if @trains[train_index].instance_of?(CargoTrain)
      wagon_amount.to_i.times { @trains[train_index].add_wagon(CargoWagon.new) }
    else
      wagon_amount.to_i.times { @trains[train_index].add_wagon(PassengerWagon.new) }
    end
  end

  def unhook_wagon_from_train
    train_index = get_selected_index("Select number of train for unhook wagon", @trains)
    if (@trains[train_index].wagons.size > 0 )
      wagon_index = get_selected_index("Select number of wagon to unhook", @trains[train_index].wagons)
      @trains[train_index].unhook_wagon(@trains[train_index].wagons[wagon_index])
    else
      puts "Selected train does not have wagons"
    end
  end

  def create_route
    if @stations.size > 1
      first_station_index = get_selected_index("Select number of start station", @stations)
      end_station_index = get_selected_index("Select number of end station", @stations)
      @routes << Route.new(@stations[first_station_index], @stations[end_station_index])
    else
      puts "Not enough stations!"
    end
  end

  def add_station_to_route
    route_index = get_selected_index("Select number of route to add station", @routes)
    station_index = get_selected_index("Select number of station to add", @stations)
    @routes[route_index].add_station(@stations[station_index])
 end

  def delete_station_from_route
    route_index = get_selected_index("Select number of route to del station", @routes)
    station_index = get_selected_index("Select number of station to del", @stations)
    @routes[route_index].del_station(@routes[route_index].stations[station_index])
  end

  def set_route_to_train
    route_index = get_selected_index("Select number of route to set to train", @routes)
    train_index = get_selected_index("Select number of train to set route", @trains)
    @trains[train_index].set_route(@routes[route_index])
  end

  def move_train_forward
    train_index = get_selected_index("Select number of train to move forward", @trains)
    @trains[train_index].go_next_station
  end

  def move_train_backward
    train_index = get_selected_index("Select number of train to move backward", @trains)
    @trains[train_index].go_previous_station
  end

  def show_menu(menu)
    puts "Enter number to select menu item or type q to exit:"
    menu.each_with_index { |value, index| puts "#{index} - #{value[:label]}" }
  end

  def call_item_handler(item, menu)
    send(menu[item.to_i][:handler]) if menu[item.to_i] && item.to_i.to_s == item
  end

  def get_user_input(text)
    puts text
    gets.chomp.to_s
  end

  def get_selected_index(text, collection)
    user_input = ""
    loop do
      puts text
      collection.each_with_index do |obj, ind|
        puts "#{ind} - #{obj.respond_to?("info") ? obj.info : obj[:menu_info]}"
      end
      user_input = get_user_input("Enter selected number:")
      break if user_input.to_i.to_s == user_input && user_input.to_i < collection.size
      puts "Selected wrong number"
    end
    return user_input.to_i
  end
end

m = Main.new
m.main
