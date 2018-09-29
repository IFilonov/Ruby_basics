class Station
  attr_reader :name

  def initialize(station_name)
    @name = station_name
    @trains = []
  end

  def train_arrive(train)
    @trains << train
  end

  def get_trains_numbers
    trains_numbers = ""
    @trains.each do |train|
      trains_numbers += "," if trains_numbers.length > 0
      trains_numbers += train.number
    end
    return trains_numbers
  end

  def send_train(train)
    @trains.delete(train)
  end
end
