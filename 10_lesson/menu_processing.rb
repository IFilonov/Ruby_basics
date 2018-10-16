require_relative 'menu_constants'
require_relative 'process_stations_and_trains'

module MenuProcessing
  include ProcessStationsAndTrains

  def create_route
    str = 'Select number of start station'
    first_idx = get_choice(str, @stations)
    str = 'Select number of end station'
    end_idx = get_choice(str, @stations) if first_idx
    return unless end_idx

    @routes << Route.new(@stations[first_idx], @stations[end_idx])
  end

  def add_station_to_route
    str = 'Select number of route to add station'
    route_idx = get_choice(str, @routes)
    str = 'Select number of station to add'
    station_idx = get_choice(str, @stations) if route_idx
    return unless station_idx

    @routes[route_idx].add_station(@stations[station_idx])
  end

  def delete_station_from_route
    str = 'Select number of route to del station'
    route_idx = get_choice(str, @routes)
    str = 'Select number of station to del'
    station_idx = get_choice(str, @stations) if route_idx
    retrun unless station_idx

    @routes[route_idx].del_station(@routes[route_idx].stations[station_idx])
  end

  def set_route_to_train
    str = 'Select number of route to set to train'
    route_idx = get_choice(str, @routes)
    str = 'Select number of train to set route'
    train_idx = get_choice(str, @trains) if route_idx
    @trains[train_idx].route(@routes[route_idx]) if train_idx
  end

  def move_train_forward
    train_idx = get_choice('Select number of train to move forward', @trains)
    @trains[train_idx].go_next_station if train_idx
  end

  def move_train_backward
    train_idx = get_choice('Select number of train to move backward', @trains)
    @trains[train_idx].go_previous_station if train_idx
  end

  def show_menu(menu)
    puts "Enter number to select menu item or type #{QUIT_MENU} to exit:"
    menu.each_with_index { |value, index| puts "#{index} - #{value[:label]}" }
  end

  def call_item_handler(item, menu)
    send(menu[item.to_i][:handler]) if menu[item.to_i] && number?(item)
  end

  def user_input(str)
    puts str
    gets.chomp.to_s
  end

  def user_input_i(text)
    input_s = ''
    loop do
      puts text
      input_s = gets.chomp.to_s
      break if number?(input_s)

      puts 'Error. Type correct number'
    end
    input_s.to_i
  end

  def get_choice(text, collection)
    input_s = ''
    if !collection.empty?
      input_s = select_from_collection(text, collection)
    else
      print 'No objects to do action.'
      user_input(' Type any key to continue')
      return nil
    end
    quit_pressed?(input_s) ? nil : input_s.to_i
  end

  def select_from_collection(text, collection)
    loop do
      puts text
      collection.each_with_index do |obj, ind|
        puts "#{ind} - #{obj.respond_to?('info') ? obj.info : obj[:menu_info]}"
      end
      input_s = user_input("Select number or type #{QUIT_MENU} to exit:")
      right_number = input_s.to_i < collection.size if number?(input_s)
      return input_s if right_number || quit_pressed?(input_s)

      puts 'Error. Selected wrong number'
    end
  end

  def number?(number_str)
    number_str.to_i.to_s == number_str
  end

  def quit_pressed?(input_str)
    input_str == QUIT_MENU
  end
end
