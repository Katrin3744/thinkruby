class Station
  attr_reader :trains

  def initialize(name)
    @name=name
    @trains=[]
  end

  def add_train(train)
    @trains<<train
  end

  def show_trains_with_type(type)
    train_with_type=[]
    @trains.each do |train|
      if train.train_type==type
        train_with_type.push(train)
      end
    end
    return train_with_type
  end

  def departure_train(train)
    @trains.delete(train)
  end
end
