# frozen_string_literal: true

require_relative 'train'
require_relative 'cargo_carriage'

class CargoTrain < Train
  def type
    :cargo
  end

  def add_carriage_with_own_type(number)
    add_carriage!(CargoCarriage.new(number))
  end
end
