class Station
  include InstanceCounter

  attr_reader :trains, :name

  def initialize(name)
    register_instance
    @name = name
    @trains = []
    validate!
  end

  def add_train(train)
    @trains << train
  end

  def show_trains_with_type(type)

    @trains.filter { |train| train.type == type }

  end

  def departure_train(train)
    @trains.delete(train)
  end

  def self.all
    ObjectSpace.each_object(Station).to_a
  end

  private # данные методы используются для поиска следующей и предыдущей станции

  def validate!
    raise "Параметр отсутствует" if name.nil? || name.length == 0
  end
end
