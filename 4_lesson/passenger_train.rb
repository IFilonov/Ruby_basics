require_relative "train"

class PassengerTrain < Train
  def initialize(number, wagon_count)
    type = :PASSENGER_TRAIN
    super(number,type,wagon_count)
  end
end
