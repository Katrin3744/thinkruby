class Route
  include InstanceCounter

  attr_reader :stations

  def initialize(first_station, last_station)
    register_instance
    @stations = []
    @stations.push(first_station, last_station)
  end

  def add_station(station)
    @stations.insert(-2, station)
  end

  def delete_station(station)
    @stations.delete(station)
  end

end
