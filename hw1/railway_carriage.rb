class RailwayCarriage
  include NameCompany
  include Accessors
  include Validation

  attr_reader :idx, :type, :seats_or_volume # полный допуск к переменным давать нельзя

  def initialize(idx, seats_or_volume)
    @idx = idx
    @seats_or_volume = seats_or_volume
    valid?
  end

  validate :idx, :format, /^\d+$/
  validate :seats_or_volume, :format, /^\d+$/

end
