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

      define_method ("validate_#{args[1].to_s}") do |var, params|
        case args[1].to_s
        when "presence"
          raise "Тип параметра #{var} не соответсвует необходимому" if instance_variable_get(var).nil? || instance_variable_get(var) == ""
        when "format"
          raise "Тип параметра #{var} не соответсвует необходимому" if instance_variable_get(var) !~ params
        when "type"
          raise "Тип параметра #{var} не соответсвует необходимому" if instance_variable_get(var).class.to_s != params
        else
          if !params.nil?
            raise "Тип параметра #{var} не соответсвует необходимому" if (instance_variable_get(var).class.to_s != params) && (instance_variable_get(var) !~ params)
          else
            raise "Тип параметра #{var} не соответсвует необходимому" if instance_variable_get(var).nil? || instance_variable_get(var) == ""
          end
        end
      end
    end
  end

  module InstanceMethods
    def validate!
      self.class.array.each do |element|
        self.send(:"validate_#{element["type"]}", element["var"], element["params"])
      end
    end

    def valid?
      self.validate!
      true
    rescue RuntimeError => e
      puts e.inspect
      false
    end

  end
end