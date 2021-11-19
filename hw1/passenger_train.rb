class PassengerTrain < Train
  def initialize(number)
    @type = "passenger"
    super(number)
  end

  def hook_up(railway_carriage)
    super(railway_carriage) if @type == railway_carriage.type
  end
end
