class Train
  attr_reader :number_of_railway_carriage, :train_type, :train_route
  attr_accessor :train_station

  def initialize(number,type,railway_carriage)
    @train_number=number
    @train_type=type
    slow_speed
    @number_of_railway_carriage=railway_carriage
  end
  def pick_up_speed
    @speed=@speed+10
  end
  def slow_speed
    @speed=0
  end

  def hook_up
    if @speed==0
        @number_of_railway_carriage+=1
    end
  end

  def unhook
    if @speed==0
      @number_of_railway_carriage-=1
    end
  end

  def train_route_add(route)
    @train_route=route.stations
    @train_station=@train_route.first
  end

  def transition_forward
      if @train_station!=@train_route.last
        current_station=@train_route.find_index(@train_station)
        @train_station=@train_route[current_station+1]
      end
  end

  def transition_back
      if @train_station!=@train_route.first
        current_station=@train_route.find_index(@train_station)
        @train_station=@train_route[current_station-1]
      end
  end

  def previous_station
    current_station=@train_route.find_index(@train_station)
    if @train_station!=@train_route.first
      return @train_route[current_station-1]
    end
  end

  def next_station
    current_station=@train_route.find_index(@train_station)
    if @train_station!=@train_route.last
      return @train_route[current_station+1]
    end
  end

end
