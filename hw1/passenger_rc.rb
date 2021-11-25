class PassengerRC < RailwayCarriage
  attr_reader :taken_seats

  def initialize(idx, seats_num)
    @type = "passenger"
    @taken_seats = 0
    super(idx, seats_num)
  end

  def take_seat
    @taken_seats += 1 if !free_seats.zero?
  end

  def free_seats
    @seats_or_volume.to_i - @taken_seats.to_i
  end

end
