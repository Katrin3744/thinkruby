class Route
  attr_reader :stations
  def initialize(first_station, last_station)
    @start_station=first_station
    @end_station=last_station
    @stations=[]
    @stations.push(@start_station,@end_station)
  end
  def add_station(station)
    @stations.delete(@stations.last)
    @stations.push(station)
    @stations.push(@end_station)
  end
  def delete_station(station)
    @stations.each do |st|
      if st==station
        if st.trains.length!=0
          st.trains.each do |tr|
            if !tr.transition_to_the_station("forward")
              tr.transition_to_the_station("back")
            end
          end
        end
        @stations.delete(st)
      end
    end
  end
  def show_stations
    @stations.each{|station| puts station}
  end
end
