class CargoRC < RailwayCarriage
  attr_reader :taken_volume

  def initialize(idx, volume)
    @type = "cargo"
    @taken_volume = 0
    super(idx, volume)
  end

  def take_volume(take)
    @taken_volume += take.to_i if free_volume >= take.to_i
  end

  def free_volume
    @seats_or_volume.to_i - @taken_volume
  end
end
