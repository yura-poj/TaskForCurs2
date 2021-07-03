module InstanceCounter
  def self.included(base)
    base.extend(ClassMethods)
    base.include(InstanceMethods)
  end

  module ClassMethods
    attr_accessor :counter

    def instances
      puts @counter
    end
  end

  module InstanceMethods
    private

    def register_instance
      self.class.counter ||= 0
      self.class.counter += 1
    end
  end
end
