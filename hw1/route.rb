class Route
  include InstanceCounter
  include Validation

  attr_reader :stations

  def initialize(first_station, last_station)
    @first_station = first_station # только для проверки работы валидации
    register_instance
    @stations = []
    @stations.push(first_station, last_station)
    valid?
  end

  validate :first_station, :type, "Station"

  def add_station(station)
    @stations.insert(-2, station)
  end

  def delete_station(station)
    @stations.delete(station)
  end

end
