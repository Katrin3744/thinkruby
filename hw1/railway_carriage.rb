class RailwayCarriage
  include NameCompany
  include Accessors
  include Validation

  attr_reader :idx, :type, :seats_or_volume # полный допуск к переменным давать нельзя


  def initialize(idx, seats_or_volume)
    self.class.instance_variable_set("@idx".to_sym,idx)
    self.class.instance_variable_set("@seats_or_volume".to_sym,seats_or_volume)
    valid?
  end

  def self.try_valid
    validate :idx, :format, /^\d+$/
    validate :seats_or_volume, :format, /^\d+$/
  end

end
