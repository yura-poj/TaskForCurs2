# frozen_string_literal: true

require_relative 'train'
require_relative 'passenger_carriage'
class PassengerTrain < Train
  def type
    :passenger
  end

  # Im not sure about it
  def add_carriage_with_own_type(number)
    add_carriage!(PassengerCarriage.new(number))
  end
end
