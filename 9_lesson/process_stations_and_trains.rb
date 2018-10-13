module ProcessStationsAndTrains
  include MenuConstants

  def create_station
    station_name = user_input('Enter new station name:')
    @stations << Station.new(station_name)
  end

  def show_stations_and_trains
    @stations.each do |station|
      puts "Station: #{station.info}"
      puts 'Trains on station:' unless station.trains.empty?
      station.each_train do |train|
        print "Number: #{train.info} Type: #{train.type} "
        puts "Wagons: #{train.wagons.size}"
      end
    end
  end

  def create_train
    attempt = 0
    begin
      type_idx = get_choice('Select type of train to create', TRAIN_CLASSES)
      return unless type_idx

      add_train(TRAIN_CLASSES[type_idx][:class_name])
    rescue RuntimeError => e
      puts e
      attempt += 1
      retry if attempt < 3
    end
  end

  def add_train(train_class)
    train_number = user_input('Enter new train number:')
    @trains << train_class.new(train_number)
  end

  def add_wagon_to_train
    train_idx = get_choice('Select number of train to add wagon', @trains)
    return unless train_idx

    wagon_amount = user_input_i('Enter amount of wagons to add:')
    create_wagons(@trains[train_idx], wagon_amount)
  end

  def create_wagons(train, wagon_amount)
    place = user_input_i("Enter #{wagon_class(train).place_str} in each wagon:")
    wagon_amount.to_i.times do |i|
      wagon = wagon_class(train).new(place, i)
      train.add_wagon(wagon)
    end
  end

  def wagon_class(train)
    train.instance_of?(CargoTrain) ? CargoWagon : PassengerWagon
  end

  def unhook_wagon_from_train
    train_idx = get_choice('Select number of train for unhook wagon', @trains)
    return unless train_idx

    str = 'Select number of wagon to unhook'
    wagon_idx = get_choice(str, @trains[train_idx].wagons)
    wagon = @trains[train_idx].wagons[wagon_idx]
    @trains[train_idx].unhook_wagon(wagon) if wagon_idx
  end

  def occupy_place_in_wagon
    train_idx = get_choice('Select number of train for occupy place', @trains)
    return unless train_idx

    str = 'Select number of wagon to occupy'
    wagon_idx = get_choice(str, @trains[train_idx].wagons)
    if @trains[train_idx].instance_of?(CargoTrain)
      place = user_input_i('Enter volume to occupy in wagon:')
    end
    @trains[train_idx].wagons[wagon_idx].occupy_place(place)
  end

  def show_wagon_list_of_train
    str = 'Select number of train for show list of wagons'
    train_idx = get_choice(str, @trains)
    return unless train_idx

    @trains[train_idx].each_wagon do |wagon|
      str = "Wagon: #{wagon.number} Type: #{wagon.type} "
      str += "Free place: #{wagon.free_place}"
      puts str
    end
  end
end
