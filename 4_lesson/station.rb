class Station
  attr_reader :name, :trains
  alias_method :info, :name

  def initialize(station_name)
    @name = station_name
    @trains = []
  end

  def train_arrive(train)
    @trains << train
  end

  def send_train(train)
    @trains.delete(train)
  end

  private
#вывод поездов по типу не используется
  def get_trains_by_type(train_class)
    @trains.select { |train| train.class == train_class }
  end
end
