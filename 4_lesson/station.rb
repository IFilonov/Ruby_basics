class Station
  attr_reader :name, :trains

  def initialize(station_name)
    @name = station_name
    @trains = []
  end

  def train_arrive(train)
    @trains << train
  end

  def get_trains_by_type(type)
    return @trains.select { |train| train.type == type }
  end

  def send_train(train)
    @trains.delete(train)
  end
end
