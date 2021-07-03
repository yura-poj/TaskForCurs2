# frozen_string_literal: true

require_relative 'carriage'

class CargoCarriage < Carriage
  attr_reader :taked_space

  def initialize(number_of_space = 50)
    @taked_space = 0
    @number_of_space = number_of_space
    register_instance
  end

  def take_space
    return 'you dont have a free space' if @taked_space >= @number_of_space

    @taked_space += 1
  end

  def rid_space
    return 'you dont have cargo' if @taked_space.zero?

    @taked_space -= 1
  end

  def free_space
    @number_of_space - @taked_space
  end

  def type
    :cargo
  end
end
