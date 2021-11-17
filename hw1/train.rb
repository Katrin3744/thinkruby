class Train
  attr_reader :number_of_railway_carriage, :train_type, :route
  attr_accessor :current_station

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
    @route = route.stations
    @current_station = @route.first
  end

  def transition_forward
    @current_station = next_station if next_station
  end

  def transition_back
    @current_station = previous_station if previous_station
  end

  def previous_station
    current_dest = @route.find_index(@current_station)
    if @current_station != @route.first
      @route[current_dest - 1]
    end
  end

  def next_station
    current_dest = @route.find_index(@current_station)
    if @current_station != @route.last
      @route[current_dest + 1]
    end
  end

end
