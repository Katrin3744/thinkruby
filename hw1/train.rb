class Train
  attr_reader :number_of_railway_carriage, :train_type, :train_route
  attr_accessor :train_station

  def initialize(number, type, railway_carriage)
    @train_number = number
    @train_type = type
    @speed = 0
    @number_of_railway_carriage = railway_carriage
  end

  def pick_up_speed
    @speed = @speed + 10
  end

  def slow_speed
    @speed = 0
  end

  def hook_up
    if @speed == 0
      @number_of_railway_carriage += 1
    end
  end

  def unhook
    if @speed == 0
      @number_of_railway_carriage -= 1
    end
  end

  def train_route_add(route)
    @train_route = route.stations
    @train_station = @train_route.first
  end

  def transition_forward
    @train_station = next_station
  end

  def transition_back
    @train_station = previous_station
  end

  def previous_station
    current_station = @train_route.find_index(@train_station)
    if @train_station != @train_route.first
      @train_route[current_station - 1]
    end
  end

  def next_station
    current_station = @train_route.find_index(@train_station)
    if @train_station != @train_route.last
      @train_route[current_station + 1]
    end
  end

end
