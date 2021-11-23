module InstanceCounter
  def self.included(base)
    base.extend ClassMethods
    base.send :include, InstanceMethods
  end

  module ClassMethods
    def instances
      @instances ||= 0
    end

    private

    def instances=(inst)
      # метод необходим для изолированного обращения через модуль InstanceMethods
      @instances = inst
    end
  end

  module InstanceMethods
    protected

    def register_instance
      self.class.send(:instances=, self.class.instances + 1)
    end
  end
end