class RailwayCarriage
  include NameCompany
  attr_reader :idx, :type

  def initialize(idx)
    @idx = idx
  end

end
