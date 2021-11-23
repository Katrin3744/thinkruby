class RailwayCarriage
  include NameCompany
  attr_reader :idx, :type

  IDX_VALIDATE = /^\d+$/

  def initialize(idx)
    @idx = idx
    validate!
  end

  private # данные методы используются для поиска следующей и предыдущей станции

  def validate!
    raise "Тип параметра не соответсвует необходимому" if idx !~ IDX_VALIDATE
  end
end
