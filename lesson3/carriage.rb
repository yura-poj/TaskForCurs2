# frozen_string_literal: true

require_relative 'manufacturer'
require_relative 'instance_counter'

class Carriage
  include Manufacturer
  include InstanceCounter

  def initialize
    register_instance
  end

  def type
    nil
  end
end
