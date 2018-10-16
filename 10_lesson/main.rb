require_relative 'cargo_train'
require_relative 'passenger_train'
require_relative 'route'
require_relative 'station'
require_relative 'passenger_wagon'
require_relative 'cargo_wagon'
require_relative 'menu_processing'
require_relative 'accessors'
require_relative 'validation'

class Main
  include MenuProcessing
  extend Accessors
  attr_accessor :stations, :trains, :routes

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

  # methods below used only public methods

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
end

m = Main.new
m.main
