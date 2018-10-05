module InstanceCounter

  def self.included(base)
    base.extend ClassMethods
    base.send :include, InstanceMethods
  end

  module ClassMethods

    def instances
      @counter
    end

    def add_instance
      @counter ||= 0
      @counter += 1
    end
  end

  module InstanceMethods

    private
    def register_instance
      self.class.add_instance
    end
  end
end
