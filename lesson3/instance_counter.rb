# frozen_string_literal: true

module InstanceCounter
  def self.included(base)
    base.extend(ClassMethods)
    base.include(InstanceMethods)
  end

  module ClassMethods
    attr_reader :counter

    def instances
      @counter
    end

    private

    attr_writer :counter
  end

  module InstanceMethods
    private

    def register_instance
      @@counter ||= 0
      @@counter += 1
    end
  end
end
