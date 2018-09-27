require_relative "train"

class CargoTrain < Train
    def initialize(number, wagon_count)
    type = :CARGO_TRAIN
    super(number,type,wagon_count)
  end
end

