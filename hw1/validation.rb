module Validation

  def self.included(base)
    base.extend ClassMethods
    base.send :include, InstanceMethods
  end

  module ClassMethods
    attr_reader :array

    def validate(*args)
      @array = [] if @array.nil?
      hash = { "type" => args[1].to_s, "var" => "@#{args[0]}".to_sym, "params" => args[2] }
      @array.push(hash)
    end

  end

  module InstanceMethods
    def validate!
      self.class.array.each do |element|
        self.validate_format(element["var"], element["type"], element["params"])
      end
    end

    def valid?
      self.validate!
      true
    rescue RuntimeError => e
      puts e.inspect
      false
    end

    private

    def validate_format(var, type, params)
      case type
      when "presence"
        raise "Тип параметра #{var} не соответсвует необходимому" if instance_variable_get(var).nil? || instance_variable_get(var) == ""
      when "format"
        raise "Тип параметра #{var} не соответсвует необходимому" if instance_variable_get(var) !~ params
      when "type"
        raise "Тип параметра #{var} не соответсвует необходимому" if instance_variable_get(var).class.to_s != params
      end
    end

  end
end
