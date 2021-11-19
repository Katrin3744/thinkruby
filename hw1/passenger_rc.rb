class PassengerRC < RailwayCarriage
  def initialize(idx)
    @type = "passenger"
    super(idx)
  end
end
