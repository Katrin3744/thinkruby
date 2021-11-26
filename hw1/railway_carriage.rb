class RailwayCarriage
  include NameCompany
  attr_reader :idx, :type, :seats_or_volume

  IDX_VALIDATE = /^\d+$/

  def initialize(idx, seats_or_volume)
    @idx = idx
    @seats_or_volume = seats_or_volume
    validate!
  end

  private # данные методы используются для поиска следующей и предыдущей станции

  def validate!
    raise "Тип параметра номера не соответсвует необходимому" if idx !~ IDX_VALIDATE
    raise "Тип параметра не соответсвует необходимому" if seats_or_volume !~ IDX_VALIDATE
  end
end
