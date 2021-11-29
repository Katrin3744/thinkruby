class Station
  include InstanceCounter
  include Accessors
  include Validation

  attr_reader :trains, :name

  def initialize(name)
    register_instance
    self.class.instance_variable_set("@name".to_sym,name)
    @trains = []
    valid?
  end

  def self.try_valid
    validate :name, :presence
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

  def send_trains(&block)
    @trains.each { |train| block.call(train) }
  end

end
