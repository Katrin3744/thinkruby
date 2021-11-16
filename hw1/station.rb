class Station
  attr_reader :trains
  def initialize(name)
    @name=name
    @trains=[]
  end
  def add_train(train)
    @trains<<train
    train.train_route.include?(self)? train.train_station=self:puts("this train doesnt have this station in the route, please be careful") # если поезд прибывает на станцию, то его текущая станция внутри объекта тоже должна меняться
  end
  def show_trains
    @trains.each{|train|return train}
  end
  def show_trains_with_type(type)
    @trains.each do |train|
      if train.train_type==type
        return train
      else puts "there is no such type of railway carriage in this train"
      end
    end
  end
  def departure_train(train)
    @trains.delete(train)
  end
end
