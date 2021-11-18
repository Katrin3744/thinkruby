class Station
  attr_reader :trains, :name

  def initialize(name)
    @name = name
    @trains = []
  end

  def add_train(train)
    @trains << train
  end

  def show_trains_with_type(type)
    @trains.filter { |train| train.class.name == type }
  end

  def departure_train(train)
    @trains.delete(train)
  end

end
