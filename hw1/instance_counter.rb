module InstanceCounter
  def self.included(base)
    base.extend ClassMethods
    base.send :include, InstanceMethods
  end

  module ClassMethods
    attr_reader :instances

    private

    def set_instances(inst)
      # метод необходим для изолированного обращения через модуль InstanceMethods
      @instances = inst
    end
  end

  module InstanceMethods
    protected

    def register_instance
      (self.class.instances.nil?) ? self.class.send(:set_instances, 1) : self.class.send(:set_instances, self.class.instances + 1)
    end
  end
end