class Route
  include InstanceCounter

  attr_reader :stations

  def initialize(first_station, last_station)
    register_instance
    @stations = []
    @stations.push(first_station, last_station)
    validate!
  end

  def add_station(station)
    @stations.insert(-2, station)
  end

  def delete_station(station)
    @stations.delete(station)
  end

  private # данные методы используются для поиска следующей и предыдущей станции

  def validate!
    raise "Тип параметра не соответсвует необходимому" if stations.first.class.name != "Station" and stations.last.class.name != "Station"
    raise "Один или оба параметра отсутствуют" if stations.first.nil? || stations.last.nil?
  end

end
