class Train
  attr_reader :number_of_railway_carriage, :train_type, :train_route
  attr_accessor :train_station

  def initialize(number,type,railway_carriage)
    @train_number=number
    @train_type=type
    @number_of_railway_carriage=railway_carriage
  end
  def pick_up_speed
    @speed=@speed+10
  end
  def slow_speed
    @speed=0
  end
  def hook_up_unhook_railway_carriage(action)
    if @speed==0
      case action
      when "hook up"
        @number_of_railway_carriage+=1
      when "unhook"
        @number_of_railway_carriage-=1
      end
    else
      puts "Train in motion, please slow"
    end
  end
  def train_route_add(route)
    @train_route=route.stations
    @train_station=@train_route.first
  end
  def transition_to_the_station(action)
    case action
    when "forward"
      if @train_station!=@train_route.last
        @train_station.departure_train(self)
        current_station=@train_route.find_index(@train_station)
        @train_station=@train_route[current_station+1]
        @train_station.add_train(self)
      else
        puts "Train locates in the end of route"
        return false
      end
    when "back"
      if @train_station!=@train_route.first
        @train_station.departure_train(self)
        current_station=@train_route.find_index(@train_station)
        @train_station=@train_route[current_station-1]
        @train_station.add_train(self)
      else
        puts "Train locates in the start of route"
        return false
      end
    end
  end
  def nearest_way
    current_station=@train_route.find_index(@train_station)
    if @train_station!=@train_route.first and @train_station!=@train_route.last
      @train_route.slice(current_station-1..current_station+1)
    else puts "train locates in the start or in the end of route"
    end
  end

end
