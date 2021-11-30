class Station
  include InstanceCounter
  include Accessors
  include Validation

  attr_accessor_with_history :trains, :name

  def initialize(name)
    register_instance
    @name = name
    @trains = []
    valid?
  end

  validate :name, :presence

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

  def send_trains(&block)
    @trains.each { |train| block.call(train) }
  end

end
