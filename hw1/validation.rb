module Validation
  def self.included(base)
    base.extend ClassMethods
    base.send :include, InstanceMethods
  end

  module ClassMethods
    def validate(*args)
      name=args[0]
      type_of_validation=args[1].to_s
      config=args[2] if !args[2].nil?
      var_name = "@#{name}".to_sym
      puts "1.#{config}, #{var_name} #{type_of_validation}"
      puts "2.#{instance_variable_get(var_name)}" # при изменении переменной через accessor данная строка дает значение установленное при инициализации,
      # не очень понятно почему, когда в основной программе значение переменной меняется
      case type_of_validation
      when "presence"
        raise "Тип параметра #{var_name} не соответсвует необходимому" if instance_variable_get(var_name).nil? || instance_variable_get(var_name) == ""
      when "format"
        raise "Тип параметра #{var_name} не соответсвует необходимому" if instance_variable_get(var_name) !~ config
      when "type"
        raise "Тип параметра #{var_name} не соответсвует необходимому" if instance_variable_get(var_name).class != config
      end
    end

  end

  module InstanceMethods
    def validate!
      puts "#{self.class}"
      self.class.try_valid
    rescue RuntimeError => e
      puts e.inspect
    end

    def valid?
      validate!
      true
    rescue
      false
    end

  end
end
