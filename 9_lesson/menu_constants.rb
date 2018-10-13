module MenuConstants
  APP_NAME = 'RailWay Manager'.freeze
  VERSION = 1.3

  MAIN_MENU = [
    { label: 'Manage stations', handler: :manage_stations },
    { label: 'Manage trains', handler: :manage_trains },
    { label: 'Manage routes', handler: :manage_routes }
  ].freeze

  STATION_MENU = [
    { label: 'Create station', handler: :create_station },
    { label: 'Show stations and trains', handler: :show_stations_and_trains }
  ].freeze

  TRAIN_MENU = [
    { label: 'Create train', handler: :create_train },
    { label: 'Add wagon to train', handler: :add_wagon_to_train },
    { label: 'Unhook wagon from train', handler: :unhook_wagon_from_train },
    { label: 'Show wagon list of train', handler: :show_wagon_list_of_train },
    { label: 'Occupy place in wagon', handler: :occupy_place_in_wagon },
    { label: 'Move train forward', handler: :move_train_forward },
    { label: 'Move train backward', handler: :move_train_backward }
  ].freeze

  ROUTE_MENU = [
    { label: 'Create route', handler: :create_route },
    { label: 'Add station to route', handler: :add_station_to_route },
    { label: 'Delete station from route', handler: :delete_station_from_route },
    { label: 'Set route to train', handler: :set_route_to_train }
  ].freeze

  QUIT_MENU = 'q'.freeze

  TRAIN_CLASSES = [
    { class_name: CargoTrain, menu_info: 'Cargo' },
    { class_name: PassengerTrain, menu_info: 'Passenger' }
  ].freeze
end
