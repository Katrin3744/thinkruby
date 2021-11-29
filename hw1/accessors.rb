module Accessors
  def self.included(base)
    base.extend ClassMethods
  end

  module ClassMethods
    def attr_accessor_with_history(*names)
      names.each do |name|
        var_name = "@#{name}".to_sym
        var_history_name = "@#{name}_history".to_sym
        define_method(name) { instance_variable_get(var_name) }
        define_method("#{name}=".to_sym) do |value|
          instance_variable_set(var_name, value)
          instance_variable_set(var_history_name, []) if instance_variable_get(var_history_name).nil?
          instance_variable_get(var_history_name).push(value)
        end
      end
    end

    def attr_history(name)
      var_history_name = "@#{name}_history".to_sym
      define_method("#{name}_history".to_sym) { instance_variable_get(var_history_name) }
    end

    def strong_attr_accessor(name, class_name)
      var_name = "@#{name}".to_sym
      define_method(name) { instance_variable_get(var_name)}
      define_method("#{name}=".to_sym) do |value|
        if class_name == value.class.name
          instance_variable_set(var_name, value)
        else
          raise "Тип параметра не соответствует введенному"
        end
      end

    end
  end
end