# frozen_string_literal: true

require_relative 'manufacturer'
require_relative 'instance_counter'
require_relative 'accessors'
require_relative 'validation'
require 'byebug'
# Имеет номер (произвольная строка) и тип (грузовой, пассажирский) и количество вагонов,
# эти данные указываются при создании экземпляра класса
# Может набирать скорость
# Может возвращать текущую скорость
# Может тормозить (сбрасывать скорость до нуля)
# Может возвращать количество вагонов
# Может прицеплять/отцеплять вагоны (по одному вагону за операцию,
# метод просто увеличивает или уменьшает количество вагонов).
# Прицепка/отцепка вагонов может осуществляться только если поезд не движется.
# Может принимать маршрут следования (объект класса Route).
# При назначении маршрута поезду, поезд автоматически помещается на первую станцию в маршруте.
# Может перемещаться между станциями, указанными в маршруте.
# Перемещение возможно вперед и назад, но только на 1 станцию за раз.
# Возвращать предыдущую станцию, текущую, следующую, на основе маршрута
class Train
  include Manufacturer
  include InstanceCounter
  include Validation
  extend Accessors

  NUMBER_FORMAT = /^(\d|[a-z]|[а-я]){3}-?(\d|[a-z]|[а-я]){2}$/i

  attr_accessor_with_history :speed, :number
  attr_reader :carriages
  validate :number, :presence
  validate :number, :format, NUMBER_FORMAT


  def self.find(number_find)
    ObjectSpace.each_object(self).find { |obj| obj.number == number_find.to_s }
  end

  def initialize(number)
    @number = number.to_s
    @speed = 0
    @carriages = []
    valid!
    register_instance
  end

  def stop
    @speed = 0
  end

  def add_carriage(carriage)
    return 'train must stop' if train_move?
    return 'type carriage is wrong' if types_of_train_and_carriage_are_not_equal(carriage)

    add_carriage!(carriage)
  end

  def remove_carriage
    return 'train must stop' if train_move?

    remove_carriage!
  end

  def add_route(route)
    @route = route
    @location = 0
    add_self_on_station
  end

  def next_station
    return 'train already on last station' if train_on_last_station

    next_station!
  end

  def previous_station
    return 'train already on first station' if train_on_first_station

    previous_station!
  end

  def print_route
    puts "Stations -> Previous: #{@route[@location - 1]} Current: #{@route[@location]} Next: #{@route[@location + 1]}"
  end

  def each_carriage(&block)
    @carriages.each(&block)
  end

  def type
    nil
  end

  private

  def add_carriage!(carriage)
    @carriages.push(carriage)
  end

  def types_of_train_and_carriage_are_not_equal?(carriage)
    carriage.type != type
  end

  def train_move?
    @speed.positive?
  end

  def remove_carriage!
    @carriages.pop
  end

  def train_on_first_station
    @location <= 0
  end

  def train_on_last_station
    @location < @carriages.size
  end

  def next_station!
    @location += 1
    add_self_on_station
  end

  def previous_station!
    @location -= 1
    add_self_on_station
  end

  def add_self_on_station
    @route.stations_list[@location].add_train(self)
  end
end

train = Train.new(12345)

__END__

p train.a
require_relative 'carriage'
train = Train.new(12345)
train.add_carriage(Carriage.new)
train.add_carriage(Carriage.new)
b = proc {|a| puts a}
train.act_with_carriage_list {|a| puts "#{a} - ggashas" }