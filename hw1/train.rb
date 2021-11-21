class Train
  attr_reader :railway_carriage, :train_type, :route
  attr_accessor :current_station

  def initialize(number)
    @train_number = number
    @speed = 0
    @route=[]
    @railway_carriage = []
  end

  def pick_up_speed
    @speed = @speed + 10
  end

  def slow_speed
    @speed = 0
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

  def hook_up(railway_carriage)
    if @speed == 0
      @railway_carriage << railway_carriage # проверяется соотвествие типов в дочерних классах, иначе должен быть тип по умолчанию
    end
  end

  def unhook(railway_carriage)
    if @speed == 0
      @railway_carriage.delete(railway_carriage)
    end
  end

  private # данные методы используются для поиска следующей и предыдущей станции

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
