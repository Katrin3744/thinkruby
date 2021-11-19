class CargoRC < RailwayCarriage
  def initialize(idx)
    @type = "cargo"
    super(idx)
  end
end
