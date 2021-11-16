class Route
  attr_reader :stations

  def initialize(first_station, last_station)
    @stations=[]
    @stations.push(first_station,last_station)
  end

  def add_station(station)
    @stations.insert(-2, station)
  end

  def delete_station(station)
    @stations.each do |st|
      if st==station
        @stations.delete(st)
      end
    end
  end

end
